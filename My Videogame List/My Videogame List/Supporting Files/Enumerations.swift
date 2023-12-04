//
//  Enumerations.swift
//  My Videogame List
//
//  Created by alessandro on 03/12/23.
//

import SwiftUI
import Supabase

enum LoginResult {
    case success(User)
    case failure(String)
}

enum GameError: Error, LocalizedError {
    case invalidURL
    case serverError
    case invalidData
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid, please try again later."
        case .serverError:
            return "There was an error with the server, please try again later."
        case .invalidData:
            return "There was an issue parsing the game data, please try again later."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
