//
//  VideogameSearchViewModel.swift
//  My Videogame List
//
//  Created by alessandro on 03/12/23.
//

import SwiftUI

extension BrowsingView {
    
    class ViewModel: ObservableObject {
        
        @Published var gameList: [Game] = []
        @Published var error: Error?
        @Published var search = ""
        @Published var debouncedSearch = ""
        private let APIKey = Private.APIKey
        private var page = 0
        
        init() {
            setupSearchDebounce()
            loadData()
        }
        
        @MainActor
        func fetchVideogames() async throws {
            do {
                page += 1
                guard let apiUrl = URL(string: "https://api.rawg.io/api/games?key=\(APIKey)&page=\(page)&page_size=10&search=\(search)") else { throw APIError.invalidURL }
                let (data, response) = try await URLSession.shared.data(from: apiUrl)
                guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw APIError.serverError }
                guard let gameResponse = try? JSONDecoder().decode(GamesList.self, from: data) else { throw APIError.invalidData }
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
        
        func setupSearchDebounce() {
            debouncedSearch = self.search
            $search
                .debounce(for: .seconds(1.0), scheduler: RunLoop.main)
                .assign(to: &$debouncedSearch)
        }
        
    }
    
}


