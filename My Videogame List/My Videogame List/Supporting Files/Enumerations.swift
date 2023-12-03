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
