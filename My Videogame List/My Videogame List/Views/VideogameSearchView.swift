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
            VStack (spacing: 0) {
                LabeledContent(content: {
                    TextField("Searchbar", text: $viewModel.search, prompt: Text("Search"))
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(UIColor.systemGray))
                })
                .padding(5)
                .background(.white)
                .cornerRadius(5)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1).foregroundColor(Color(UIColor.systemGray4)))
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 1)
                .onChange(of: viewModel.debouncedSearch) {
                    viewModel.refreshVideogames()
                }
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
            }
            .background(Color(UIColor.systemGray6))
            .navigationTitle("Browsing")
        }
        .alert(isPresented: $isAlertPresented, content: {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.error?.localizedDescription ?? "")
            )
        })
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
