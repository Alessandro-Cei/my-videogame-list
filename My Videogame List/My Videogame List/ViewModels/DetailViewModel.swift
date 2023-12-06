//
//  DetailViewModel.swift
//  My Videogame List
//
//  Created by alessandro on 05/12/23.
//

import SwiftUI
import Supabase

extension DetailView {
    
    class ViewModel: ObservableObject {
        
        private var user: User?
        
        @MainActor
        func addGame(gameId: Int) async throws {
            guard let url = URL(string: Private.databaseURL) else { throw DatabaseError.invalidURL }
            let client = SupabaseClient(supabaseURL: url, supabaseKey: Private.databaseKey)
            //Better error handling
            do {
                user = try await client.auth.user()
            } catch {
                throw DatabaseError.failedUserRetrieval
            }
            if let user = self.user {
                let game = UserGame(userId: user.id, gameId: "\(gameId)")
                do {
                    try await client.database.from("user_games").insert(game).execute()
                } catch {
                    throw error
                }
            }
        }
        
        @MainActor
        func removeGame(gameId: Int) async throws {
            guard let url = URL(string: Private.databaseURL) else { throw DatabaseError.invalidURL }
            let client = SupabaseClient(supabaseURL: url, supabaseKey: Private.databaseKey)
            //Better error handling
            do {
                user = try await client.auth.user()
            } catch {
                throw DatabaseError.failedUserRetrieval
            }
            if let user = self.user {
                let game = UserGame(userId: user.id, gameId: "\(gameId)")
                do {
                    try await client.database.from("user_games").delete().eq("game_id", value: game.gameId).execute()
                } catch {
                    throw error
                }
            }
        }
        
    }
    
}
