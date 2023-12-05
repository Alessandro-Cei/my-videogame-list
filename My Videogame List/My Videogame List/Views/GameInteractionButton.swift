//
//  GameInteractionButton.swift
//  My Videogame List
//
//  Created by alessandro on 05/12/23.
//

import SwiftUI

struct GameInteractionButton: View {
    
    var type: ButtonType
    var interaction: @MainActor() -> Void
    
    var body: some View {
        Button(action: {
            interaction()
        }, label: {
            Text(type == .addGame ? "Add to collection" : "Remove from collection")
                .font(.title3)
                .foregroundColor(.white)
                .padding()
                .background(.blue)
                .cornerRadius(10)
        })
    }
}

#Preview {
    GameInteractionButton(
        type: .addGame, 
        interaction: {print("Hello")}
    )
}
