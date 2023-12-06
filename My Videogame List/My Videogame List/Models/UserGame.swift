//
//  UserGame.swift
//  My Videogame List
//
//  Created by alessandro on 05/12/23.
//

import SwiftUI

struct UserGame: Codable, Hashable {
    
    var userId: UUID
    var gameId: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case gameId = "game_id"
    }
}
