//
//  FavoriteDeckListView.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/06/04.
//

import SwiftUI

struct FavoriteDeckListView: View {
    
    @ObservedObject var viewModel = DeckListViewModel.shared
    
    var body: some View {
        VStack {
            LineView()
                .padding(.bottom)
            
            if viewModel.favoriteDecks.count > 0 {
                // デッキが1件以上登録済みなら一覧をListで表示
                List {
                    ForEach(viewModel.favoriteDecks) { deck in
                        VStack {
                            HStack {
                                NavigationLink(destination: DeckDetailView(deck: deck)) {
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
                Text("NoDecks")
                    .font(.system(size: 20))
                    .opacity(0.5)
                Spacer()
            }
        }
        // ヘッダー
        .navigationTitle("Favorite")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .bottomBar) {
                BannerView()
                    .frame(width: UIScreen.main.bounds.width, height: 50)
            }
        }
    }
}

struct FavoriteDeckCellView: View {
    
    @State var deck: Deck
    @State var isFavorite: Bool
    @State var deckName: String
    
    var body: some View {
        HStack {
            Image(systemName: "star")
                .foregroundColor(isFavorite ? Color("yellowLine"): Color("basic"))
                .onTapGesture(perform: {
                    isFavorite.toggle()
                    Deck.updateDeck(deck: deck, newDeckName: deck.deckName, newDeckCode: deck.deckCode, newDeckMemo: deck.deckMemo, newDeckImageData: deck.deckImageData, isFavorite: !deck.isFavorite)
                })
            
            Text(deckName)
        }
    }
}
