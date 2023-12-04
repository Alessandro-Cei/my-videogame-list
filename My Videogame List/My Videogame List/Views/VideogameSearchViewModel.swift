//
//  VideogameSearchViewModel.swift
//  My Videogame List
//
//  Created by alessandro on 03/12/23.
//

import SwiftUI

extension VideogameSearchView {
        
    class ViewModel: ObservableObject {
        
        @Published var gameList: [Game] = Array(repeating: Game(name: "GTA V", backgroundImage: "https://fastly.picsum.photos/id/776/200/200.jpg?hmac=Rq9krBqm0Qss3AbgE4BjL1Iu891xLPTkf1xNf0ezp38"), count: 10)
        let APIKey = "API_KEY"
        
        func fetchVideogames() async {
            guard let apiUrl = URL(string: "https://api.rawg.io/api/games?key=\(APIKey)&page=1&page_size=10") else {return}
            do {
                let (data, _) = try await URLSession.shared.data(from: apiUrl)
                let decoder = JSONDecoder()
                let gameResponse = try decoder.decode(GamesList.self, from: data)
                DispatchQueue.main.async {
                    self.gameList = gameResponse.results
                }
            } catch {
                print("Error: \(error)")
                return
            }
        }
        
    }
    
}


