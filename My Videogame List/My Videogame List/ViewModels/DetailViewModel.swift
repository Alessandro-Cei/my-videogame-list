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
        
        @Published var error: Error?
        private var user: User?
        
        @MainActor
        func addGame(gameId: Int) async throws {
            do {
                guard let url = URL(string: Private.databaseURL) else { throw DatabaseError.invalidURL }
                let client = SupabaseClient(supabaseURL: url, supabaseKey: Private.databaseKey)
                //Better error handling
                user = try await client.auth.user()
                if let user = self.user {
                    let game = UserGame(userId: user.id, gameId: "\(gameId)")
                    do {
                        try await client.database.from("user_games").insert(game).execute()
                    } catch {
                        if let insertErrorCode = (error as? PostgREST.PostgrestError)?.code {
                            if insertErrorCode == "23505" {
                                throw DatabaseError.duplicateRecord
                            } else {
                                throw error
                            }
                        } else {
                            throw error
                        }
                    }
                } else {
                    throw DatabaseError.failedUserRetrieval
                }
            } catch {
                self.error = error
            }
        }
        
        @MainActor
        func removeGame(gameId: Int) async throws {
            do {
                guard let url = URL(string: Private.databaseURL) else { throw DatabaseError.invalidURL }
                let client = SupabaseClient(supabaseURL: url, supabaseKey: Private.databaseKey)
                //Better error handling
                user = try await client.auth.user()
                if let user = self.user {
                    let game = UserGame(userId: user.id, gameId: "\(gameId)")
                    try await client.database.from("user_games").delete().eq("game_id", value: game.gameId).execute()
                } else {
                    throw DatabaseError.failedUserRetrieval
                }
            } catch {
                self.error = error
            }
        }
        
    }
    
}
