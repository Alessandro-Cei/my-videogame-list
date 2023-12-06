//
//  UserGame.swift
//  My Videogame List
//
//  Created by alessandro on 05/12/23.
//

import SwiftUI

struct UserGame: Codable, Identifiable, Hashable {
    var id: UUID
    var gameId: String
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case gameId = "game_id"
    }
}
