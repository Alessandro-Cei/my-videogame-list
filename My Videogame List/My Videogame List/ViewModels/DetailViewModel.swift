//
//  DetailViewModel.swift
//  My Videogame List
//
//  Created by alessandro on 05/12/23.
//

import SwiftUI

extension DetailView {
    
    class ViewModel: ObservableObject {
        
        @MainActor
        func addGame() {
            print("Adding Game")
        }
        
        @MainActor
        func removeGame() {
            print("Removing Game")
        }
        
    }
    
}
