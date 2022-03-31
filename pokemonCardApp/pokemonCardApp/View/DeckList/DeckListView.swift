//
//  DeckListView.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/03/27.
//

import SwiftUI

struct DeckListView: View {
    
    @ObservedObject var viewModel = DeckListViewModel.shared
    
    var body: some View {
        VStack {
            // ライン画像
            Image("lineImage")
                .renderingMode(.original)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.05)
                .padding(.bottom)
            
            List {
                ForEach(viewModel.decks) { deck in
                    VStack {
                        NavigationLink(deck.deckName, destination: DeckDetailView(name: deck.deckName, code: deck.deckCode, memo: deck.deckMemo, imageData: deck.deckImageData))
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            viewModel.deleteDeck(deck: deck)
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                    }
    //                .swipeActions(edge: .leading) {
    //                        Button {
    //                            viewModel.updatingDeck = deck
    //                            viewModel.deckName = deck.deckName
    //                            viewModel.deckCode = deck.deckCode
    //                            viewModel.isShowAddView.toggle()
    //                        } label: {
    //                            Image(systemName: "pencil.circle")
    //                        }
    //                        .tint(.green)
    //                }
                }
            }
            .listStyle(InsetListStyle())
        }
        .navigationTitle("MY COLLECTION")
        .navigationBarTitleDisplayMode(.inline)
    }
}
