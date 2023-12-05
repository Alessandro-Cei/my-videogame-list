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
        
        let databaseURL = Private.databaseURL
        let databaseKey = Private.databaseKey
                
        func signIn(email mail:String, password psw:String) async -> LoginResult {
            
            var currentUser: User?
            guard let url = URL(string: databaseURL) else {return LoginResult.failure("Failed Login")}
            let client = SupabaseClient(supabaseURL: url, supabaseKey: databaseKey)
            do {
                try await client.auth.signIn(email: mail, password: psw)
            } catch {
                print("Error: failed login attempt")
            }
            do {
                currentUser = try await client.auth.user()
            } catch {
                print("Error: failed user retrieval")
            }
            if currentUser != nil {
                return LoginResult.success(currentUser!)
            } else {
                return LoginResult.failure("Failed Login")
            }
            
        }
        
        func signUp(email mail:String, password psw:String) async -> LoginResult {
            
            var currentUser: User?
            guard let url = URL(string: databaseURL) else {return LoginResult.failure("Failed Login")}
            let client = SupabaseClient(supabaseURL: url, supabaseKey: databaseKey)
            do {
                try await client.auth.signUp(email: mail, password: psw)
            } catch {
                print("Error: failed signup attempt")
            }
            do {
                currentUser = try await client.auth.user()
            } catch {
                print("Error: failed user retrieval")
            }
            if currentUser != nil {
                return LoginResult.success(currentUser!)
            } else {
                return LoginResult.failure("Failed Login")
            }
            
        }
        
    }
    
}
