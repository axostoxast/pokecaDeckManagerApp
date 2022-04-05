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
            LineView()
                .padding(.bottom)
            
            if viewModel.decks.count > 0 {
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
                    }
                }
                .listStyle(InsetListStyle())
                
                Spacer()
            } else {
                Spacer()
                Text("デッキが未登録です")
                    .font(.system(size: 20))
                    .opacity(0.5)
                Spacer()
            }
        }
        .navigationTitle("MY COLLECTION")
        .navigationBarTitleDisplayMode(.inline)
    }
}
