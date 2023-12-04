//
//  VideogameSearchView.swift
//  My Videogame List
//
//  Created by alessandro on 03/12/23.
//

import SwiftUI

struct VideogameSearchView: View {
    
    @StateObject var viewModel = ViewModel()
    @State var isPresented = false
    @State var focusedGame: Game = Game(name: "", backgroundImage: "")
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Videogames List")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                ScrollView {
                    ForEach(viewModel.gameList, id: \.self) { game in
                        VideogameRow(urlString: game.backgroundImage, title: game.name)
                            .frame(height: 100)
                            .onTapGesture {
                                focusedGame = game
                                isPresented = true
                            }
                    }
                }
                .redacted(reason: viewModel.gameList.isEmpty ? .placeholder : [])
                
            }
            .onAppear() {
                //            Task {
                //                await viewModel.fetchVideogames()
                //            }
            }
            
        }
        .sheet(isPresented: $isPresented){
            NavigationStack {
                AddVideogameView(game: $focusedGame)
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(role: .cancel, action: {
                                isPresented.toggle()
                            }, label: {
                                Text("Cancel")
                            })
                        }
                    })
            }
            
        }
        
        
    }
}

#Preview {
    VideogameSearchView()
}
