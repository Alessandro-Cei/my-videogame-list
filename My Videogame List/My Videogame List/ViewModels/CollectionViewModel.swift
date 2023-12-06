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
        private var gameIDs: [String] = []
        
        init() {
            loadData()
        }
        
        @MainActor
        func fetchGameIDs() async throws {
            guard let url = URL(string: Private.databaseURL) else { throw GameError.invalidURL }
            let client = SupabaseClient(supabaseURL: url, supabaseKey: Private.databaseKey)
            //Add error handling
            let user = try await client.auth.session.user
            guard let games: [UserGame] = try await client.database.from("user_games").select().eq("user_id", value: user.id).execute().value else { throw GameError.serverError }
            gameIDs.append(contentsOf: games.map{ $0.gameId })
        }
        
        @MainActor
        func fetchVideogames(id: String) async throws {
            do {
                guard let apiUrl = URL(string: "https://api.rawg.io/api/games/\(id)?key=\(Private.APIKey)") else { throw GameError.invalidURL }
                let (data, response) = try await URLSession.shared.data(from: apiUrl)
                guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw GameError.serverError }
                guard let game = try? JSONDecoder().decode(Game.self, from: data) else { throw GameError.invalidData }
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
        
    }
    
}
