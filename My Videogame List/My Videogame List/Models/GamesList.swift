//
//  GamesList.swift
//  My Videogame List
//
//  Created by alessandro on 04/12/23.
//

import SwiftUI

struct GamesList: Codable {
    let results: [Game]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}
