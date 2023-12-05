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
                    GameInteractionButton(type: type, interaction: type == .addGame ? viewModel.addGame : viewModel.removeGame)
                    Spacer()
                }
                .padding()
                Spacer()
            }
        }
        
    }
}

#Preview {
    DetailView(game: .constant(Game(name: "GTA V", backgroundImage: "")), type: .addGame)
}
