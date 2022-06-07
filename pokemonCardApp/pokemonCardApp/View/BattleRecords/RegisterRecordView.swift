//
//  RegisterRecordView.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/06/07.
//

import SwiftUI

struct RegisterRecordView: View {
    
    @ObservedObject var viewModel = DeckListViewModel.shared
    @State private var winnerDeckNameList: [String] = ["勝利デッキ"]
    @State private var loserDeckNameList: [String] = ["敗北デッキ"]
    @State private var winner = ""
    @State private var loser = ""
    @State private var winnerGotPoint = ""
    @State private var loserGotPoint = ""
    
    var body: some View {
        VStack(spacing: 0){
            
            // 勝敗
            
            // 先攻/後攻
            
            // 使用デッキ
            
            // 相手デッキ
            
            // メモ
            
            HStack(spacing: 50) {
                Picker(selection: $winner, label: Text("勝利デッキ")) {
                    ForEach(winnerDeckNameList, id: \.self) { value in
                        Text(value).tag(value)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                Picker(selection: $loser, label: Text("敗北デッキ")) {
                    ForEach(loserDeckNameList, id: \.self) { value in
                        Text(value).tag(value)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
            }
            
            HStack {
                Text("獲得サイド数")
                
                TextField("", text: $winnerGotPoint)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 50)
                    .keyboardType(.numberPad)
                
                Text("獲得サイド数")
                
                TextField("", text: $loserGotPoint)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 50)
                    .keyboardType(.numberPad)
            }
            .padding(.bottom)
            
            Button("登録") {
                print("登録")
            }
            .font(.system(size: 20))
            .foregroundColor(Color("basic"))
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
            
            Divider()
                .frame(width: UIScreen.main.bounds.width * 0.2, height: 3, alignment: .center)
                .background(Color("blueLine"))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
            Divider()
                .frame(width: UIScreen.main.bounds.width * 0.2, height: 3, alignment: .center)
                .background(Color("yellowLine"))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
        }
        .onAppear {
            viewModel.decks.forEach({ deck in
                winnerDeckNameList.append(deck.deckName)
                loserDeckNameList.append(deck.deckName)
            })
            
        }
        .navigationTitle("RegisterRecord")
        .navigationBarTitleDisplayMode(.inline)
    }
}
