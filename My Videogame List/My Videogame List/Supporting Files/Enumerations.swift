//
//  Enumerations.swift
//  My Videogame List
//
//  Created by alessandro on 03/12/23.
//

import SwiftUI
import Supabase

enum DatabaseError: Error, LocalizedError {
    case invalidURL
    case invalidData
    case failedLogin
    case failedSignUp
    case failedUserRetrieval
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid, please try again later."
        case .invalidData:
            return "There was an issue parsing the game data, please try again later."
        case .failedLogin:
            return "Failed login attempt."
        case .failedSignUp:
            return "Failed signup attempt."
        case .failedUserRetrieval:
            return "Failed user retrieval."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}

enum APIError: Error, LocalizedError {
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

enum ButtonType {
    case addGame
    case removeGame
}
