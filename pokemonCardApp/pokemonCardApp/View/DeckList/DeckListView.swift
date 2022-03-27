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
        List {
            ForEach(viewModel.decks) { deck in
                HStack {
//                    Image(systemName: "circlebadge.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 15, height: 15)
//                        .foregroundColor(.blue)
                    
                    VStack {
                        NavigationLink(deck.deckName, destination: DeckDetailView(name: deck.deckName, code: deck.deckCode, memo: deck.deckMemo))
                    }
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
        .navigationTitle("デッキ一覧")
    }
}
