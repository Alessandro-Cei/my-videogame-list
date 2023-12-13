//
//  CollectionViewModel.swift
//  My Videogame List
//
//  Created by alessandro on 05/12/23.
//

import SwiftUI
import Supabase

extension CollectionView {
    
    class ViewModel: ObservableObject {
        
        @Published var gameList: [Game] = []
        @Published var error: Error?
        @Published var gameIDs: [String] = []
        private var user: User?
        
        init() {
            loadData()
        }
        
        @MainActor
        func fetchGameIDs() async throws {
            do {
                guard let url = URL(string: Private.databaseURL) else { throw DatabaseError.invalidURL }
                let client = SupabaseClient(supabaseURL: url, supabaseKey: Private.databaseKey)
                //Better error handling
                do {
                    user = try await client.auth.session.user
                } catch {
                    throw DatabaseError.failedUserRetrieval
                }
                if let user = self.user {
                    guard let games: [UserGame] = try await client.database.from("user_games").select().eq("user_id", value: user.id).execute().value else { throw DatabaseError.invalidData }
                    gameIDs.append(contentsOf: games.map{ $0.gameId })
                }
            } catch {
                self.error = error
            }
        }
        
        @MainActor
        func fetchVideogames(id: String) async throws {
            do {
                guard let apiUrl = URL(string: "https://api.rawg.io/api/games/\(id)?key=\(Private.APIKey)") else { throw APIError.invalidURL }
                let (data, response) = try await URLSession.shared.data(from: apiUrl)
                guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw APIError.serverError }
                guard let game = try? JSONDecoder().decode(Game.self, from: data) else { throw APIError.invalidData }
                gameList.append(game)
            } catch {
                self.error = error
            }
        }
        
        func loadData() {
            Task(priority: .medium) {
                try await fetchGameIDs()
                for id in gameIDs {
                    try await fetchVideogames(id: id)
                }
            }
        }
        
        func refreshVideogames() {
            gameList.removeAll()
            gameIDs.removeAll()
            loadData()
        }
        
    }
    
}
