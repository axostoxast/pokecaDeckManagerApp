//
//  AddDeckView.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/03/27.
//

import SwiftUI

struct AddDeckView: View {
    
    @ObservedObject var viewModel = DeckListViewModel.shared
    
    var body: some View {
        VStack {
            TextField("デッキ名", text: $viewModel.deckName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("デッキコード", text: $viewModel.deckCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("メモ", text: $viewModel.deckMemo)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Spacer()
            
            Button(action: {
                viewModel.addDeck()
            }) {
                Text("登録")
            }
        }
        .navigationTitle("デッキを追加")
    }
}
