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
        
        let databaseURL = "https://repwapoydvwdlrzbfwmi.supabase.co"
        let databaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJlcHdhcG95ZHZ3ZGxyemJmd21pIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE1MjEwOTIsImV4cCI6MjAxNzA5NzA5Mn0.bTeQbGghC_21IxUKdnkDvOSQ46xudwtm1vMAgbsL43g"
                
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
