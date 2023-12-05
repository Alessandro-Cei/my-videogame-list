//
//  CollectionViewModel.swift
//  My Videogame List
//
//  Created by alessandro on 05/12/23.
//

import SwiftUI

extension CollectionView {
    
    class ViewModel: ObservableObject {
        
        @Published var gameList: [Game] = Array(repeating: Game(name: "GTA", backgroundImage: ""), count: 20)
        @Published var error: Error?
        
        init() {
            //loadData()
        }
        
        @MainActor
        func fetchVideogames() async throws {
            
        }
        
        func loadData() {
            Task(priority: .medium) {
                try await fetchVideogames()
            }
        }
        
    }
    
}
