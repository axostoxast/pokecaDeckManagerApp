//
//  TopView.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/03/27.
//

import SwiftUI

struct TopView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("デッキ一覧", destination: DeckListView())
                    .padding(.bottom)
                NavigationLink("デッキ作成", destination: AddDeckView())
            }
        }
        .navigationTitle("ポケカアプリ")
    }
}

