//
//  AddVideogameView.swift
//  My Videogame List
//
//  Created by alessandro on 04/12/23.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject private var viewModel = ViewModel()
    @Binding var game: Game
    @Binding var isPresented: Bool
    
    var type: ButtonType
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                Spacer()
                VStack (spacing: 10){
                    Spacer()
                    Text(game.name)
                        .multilineTextAlignment(.leading)
                        .font(.largeTitle)
                    AsyncImage(url: URL(string: game.backgroundImage))
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.5, height: geo.size.width * 0.5)
                        .cornerRadius(20)
                    Spacer()
                    Spacer()
                    Button(action: {
                        switch type {
                        case .addGame:
                            Task {
                                try await viewModel.addGame(gameId: game.gameId)
                                isPresented.toggle()
                            }
                        case .removeGame:
                            Task {
                                try await viewModel.removeGame(gameId: game.gameId)
                                isPresented.toggle()
                            }
                        }
                    }, label: {
                        Text(type == .addGame ? "Add to collection" : "Remove from collection")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()
                            .background(.blue)
                            .cornerRadius(10)
                    })
                    Spacer()
                }
                .padding()
                Spacer()
            }
        }
        
    }
}

#Preview {
    DetailView(game: .constant(Game(gameId: 3498, name: "GTA V", backgroundImage: "")), isPresented: .constant(true), type: .addGame)
}
