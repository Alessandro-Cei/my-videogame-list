//
//  CollectionView.swift
//  My Videogame List
//
//  Created by alessandro on 05/12/23.
//

import SwiftUI

struct CollectionView: View {
    
    @StateObject private var viewModel = ViewModel()
    @State var isPresented = false
    @State private var isAlertPresented = false
    @State var focusedGame: Game = Game(gameId: 3498, name: "", backgroundImage: "")
    @State var search = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { game in
                    VideogameRow(urlString: game.backgroundImage, title: game.name)
                        .onAppear() {
                            //Pagination
                        }
                        .onTapGesture {
                            //Open game detail
                            focusedGame = game
                            isPresented = true
                        }
                        .redacted(reason: viewModel.gameList.count == viewModel.gameIDs.count ? [] : .placeholder)
                }
                .frame(height: 50)
            }
            .searchable(text: $search)
            .refreshable {
                viewModel.refreshVideogames()
            }
            .onReceive(viewModel.$error, perform: { error in
                if (error != nil) {
                    isAlertPresented.toggle()
                }
            })
            .onChange(of: isPresented) { oldState, newState in
                if newState == false && !viewModel.gameList.isEmpty {
                    viewModel.refreshVideogames()
                }
            }
            .alert(isPresented: $isAlertPresented, content: {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.error?.localizedDescription ?? "")
                )
            })
            .navigationTitle("My collection")
        }
        .sheet(isPresented: $isPresented){
            NavigationStack {
                DetailView(game: $focusedGame, isPresented: $isPresented, type: .removeGame)
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
    var searchResults: [Game] {
            if search.isEmpty {
                return viewModel.gameList
            } else {
                return viewModel.gameList.filter { $0.name.uppercased().contains(search.uppercased()) }
            }
    }
}

#Preview {
    CollectionView()
}
