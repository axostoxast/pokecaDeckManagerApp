//
//  RegisterRecordView.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/06/07.
//

import SwiftUI

struct RegisterRecordView: View {
    
    @ObservedObject var viewModel = DeckListViewModel.shared
    @State private var deckNameList: [String] = ["デッキ"]
    @State private var winner = ""
    @State private var loser = ""
    @State private var winnerGotPoint = ""
    @State private var loserGotPoint = ""
    
    var body: some View {
        VStack{
            HStack {
                Text("勝利デッキ")
                
                Text("敗北デッキ")
                
                Text("勝者獲得サイド")
                
                Text("敗者獲得サイド")
            }
            
            HStack {
                Picker(selection: $winner, label: Text("勝利デッキ")) {
                    ForEach(deckNameList, id: \.self) { value in
                        Text(value).tag(value)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                Picker(selection: $loser, label: Text("敗北デッキ")) {
                    ForEach(deckNameList, id: \.self) { value in
                        Text(value).tag(value)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                TextField("", text: $winnerGotPoint)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("", text: $loserGotPoint)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .onAppear {
            viewModel.decks.forEach({ deck in
                deckNameList.append(deck.deckName)
            })
        }
        .navigationTitle("RegisterRecord")
        .navigationBarTitleDisplayMode(.inline)
    }
}
