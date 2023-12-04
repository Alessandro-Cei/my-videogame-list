//
//  ContentView.swift
//  My Videogame List
//
//  Created by alessandro on 02/12/23.
//

import SwiftUI
import Supabase

struct ContentView: View {
    
    @State var user: User?
    
    var body: some View {
        if (user == nil) {
            VideogameSearchView()
        } else {
            LoginView(user: $user)
        }
    }
    
}

#Preview {
    ContentView()
}
