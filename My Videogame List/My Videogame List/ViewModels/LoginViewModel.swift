//
//  LoginViewModel.swift
//  My Videogame List
//
//  Created by alessandro on 02/12/23.
//

import SwiftUI
import Supabase

extension LoginView {
    
    class ViewModel: ObservableObject {
        
        private let databaseURL = Private.databaseURL
        private let databaseKey = Private.databaseKey
        @Published var error: Error?
        @Published var user: User?
           
        @MainActor
        func signIn(email mail:String, password psw:String) async throws {
            guard let url = URL(string: databaseURL) else { throw DatabaseError.invalidURL }
            let client = SupabaseClient(supabaseURL: url, supabaseKey: databaseKey)
            do {
                try await client.auth.signIn(email: mail, password: psw)
            } catch {
                throw DatabaseError.failedLogin
            }
            do {
                user = try await client.auth.user()
            } catch {
                throw DatabaseError.failedUserRetrieval
            }
        }
        
        @MainActor
        func signUp(email mail:String, password psw:String) async throws {
            guard let url = URL(string: databaseURL) else { throw DatabaseError.invalidURL }
            let client = SupabaseClient(supabaseURL: url, supabaseKey: databaseKey)
            do {
                try await client.auth.signUp(email: mail, password: psw)
            } catch {
                throw DatabaseError.failedSignUp
            }
            do {
                user = try await client.auth.user()
            } catch {
                throw DatabaseError.failedUserRetrieval
            }
        }
        
    }
    
}
