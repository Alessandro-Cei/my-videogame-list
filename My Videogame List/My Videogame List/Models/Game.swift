//
//  Game.swift
//  My Videogame List
//
//  Created by alessandro on 04/12/23.
//

import SwiftUI

struct Game: Codable, Hashable {
    let name: String
    let backgroundImage: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case backgroundImage = "background_image"
    }
}
