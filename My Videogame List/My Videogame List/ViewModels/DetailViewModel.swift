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
        
        @MainActor
        func addGame(gameId: Int) async throws {
            guard let url = URL(string: Private.databaseURL) else { throw GameError.invalidURL }
            let client = SupabaseClient(supabaseURL: url, supabaseKey: Private.databaseKey)
            //Add better error handling
            let user = try await client.auth.session.user
            let game = UserGame(userId: user.id, gameId: "\(gameId)")
            do {
                try await client.database.from("user_games").insert(game).execute()
            } catch {
                print(error.localizedDescription)
            }
        }
        
        @MainActor
        func removeGame(gameId: Int) async throws {
            guard let url = URL(string: Private.databaseURL) else { throw GameError.invalidURL }
            let client = SupabaseClient(supabaseURL: url, supabaseKey: Private.databaseKey)
            //Add better error handling
            let user = try await client.auth.session.user
            let game = UserGame(userId: user.id, gameId: "\(gameId)")
            do {
                try await client.database.from("user_games").delete().eq("game_id", value: game.gameId).execute()
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
}
