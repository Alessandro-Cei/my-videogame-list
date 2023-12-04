//
//  AddVideogameView.swift
//  My Videogame List
//
//  Created by alessandro on 04/12/23.
//

import SwiftUI

struct AddVideogameView: View {
    
    @Binding var game: Game
    
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
                        //Add to database
                    }, label: {
                        Text("Add to collection")
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
    AddVideogameView(game: .constant(Game(name: "GTA V", backgroundImage: "")))
}
