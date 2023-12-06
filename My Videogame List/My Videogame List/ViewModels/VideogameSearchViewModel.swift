//
//  VideogameSearchViewModel.swift
//  My Videogame List
//
//  Created by alessandro on 03/12/23.
//

import SwiftUI

extension VideogameSearchView {
        
    class ViewModel: ObservableObject {
        
        @Published var gameList: [Game] = []
        @Published var error: Error?
        private let APIKey = Private.APIKey
        private var page = 0
        init() {
            loadData()
        }
        
        @MainActor
        func fetchVideogames() async throws {
            do {
                page += 1
                guard let apiUrl = URL(string: "https://api.rawg.io/api/games?key=\(APIKey)&page=\(page)&page_size=10") else { throw GameError.invalidURL }
                let (data, response) = try await URLSession.shared.data(from: apiUrl)
                guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw GameError.serverError }
                guard let gameResponse = try? JSONDecoder().decode(GamesList.self, from: data) else { throw GameError.invalidData }
                gameList.append(contentsOf: gameResponse.results)
            } catch {
                self.error = error
            }
        }
        
        func loadData() {
            Task(priority: .medium) {
                try await fetchVideogames()
            }
        }
        
        func refreshVideogames() {
            gameList.removeAll()
            page = 0
            loadData()
        }
    }
    
}


