//
//  VideogameSearchView.swift
//  My Videogame List
//
//  Created by alessandro on 03/12/23.
//

import SwiftUI

struct VideogameSearchView: View {
    
    @StateObject private var viewModel = ViewModel()
    @State var isPresented = false
    @State private var isAlertPresented = false
    @State var focusedGame: Game = Game(gameId: 3498, name: "", backgroundImage: "")
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.gameList, id: \.self) { game in
                    VideogameRow(urlString: game.backgroundImage, title: game.name)
                        .onAppear() {
                            //Pagination
                            if game == viewModel.gameList.last {
                                viewModel.loadData()
                            }
                        }
                        .onTapGesture {
                            //Open game detail
                            focusedGame = game
                            isPresented = true
                        }
                }
                .frame(height: 50)
            }
            .listStyle(.insetGrouped)
            .redacted(reason: viewModel.gameList.isEmpty ? .placeholder : [])
            .refreshable {
                viewModel.refreshVideogames()
            }
            .onReceive(viewModel.$error, perform: { error in
                if (error != nil) {
                    isAlertPresented.toggle()
                }
            })
            .alert(isPresented: $isAlertPresented, content: {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.error?.localizedDescription ?? "")
                )
            })
            .navigationTitle("Videogames List")
        }
        .sheet(isPresented: $isPresented){
            NavigationStack {
                DetailView(game: $focusedGame, isPresented: $isPresented, type: .addGame)
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
