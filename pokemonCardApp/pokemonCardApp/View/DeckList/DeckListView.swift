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
                // デッキが1件以上登録済みなら一覧をListで表示
                List {
                    ForEach(viewModel.decks) { deck in
                        VStack {
                            HStack {
                                NavigationLink(destination: DeckDetailView(name: deck.deckName, code: deck.deckCode, memo: deck.deckMemo, imageData: deck.deckImageData)) {
                                    DeckCellView(deck: deck, isFavorite: deck.isFavorite, deckName: deck.deckName, viewModel: viewModel)
                                }
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
                    }
                }
                .listStyle(InsetListStyle())
                
                Spacer()
            } else {
                // デッキ未登録の場合
                Spacer()
                Text("デッキが未登録です")
                    .font(.system(size: 20))
                    .opacity(0.5)
                Spacer()
            }
        }
        // ヘッダー
        .navigationTitle("MY COLLECTION")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DeckCellView: View {
    
    @State var deck: Deck
    @State var isFavorite: Bool
    @State var deckName: String
    @StateObject var viewModel: DeckListViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "star")
                .foregroundColor(isFavorite ? Color("yellowLine"): Color("basic"))
                .onTapGesture(perform: {
                    viewModel.updatingDeck = deck
                    viewModel.deckName = deck.deckName
                    viewModel.deckCode = deck.deckCode
                    viewModel.deckImageData = deck.deckImageData
                    viewModel.deckMemo = deck.deckMemo
                    viewModel.isFavorite = !deck.isFavorite
                    viewModel.updateDeck()
                })
            
            Text(deckName)
        }
    }
}
