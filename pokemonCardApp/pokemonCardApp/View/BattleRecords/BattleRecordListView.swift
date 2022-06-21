//
//  BattleRecordListView.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/06/10.
//

import SwiftUI

struct SelectDeckForRecordView: View {
    @ObservedObject var deckViewModel = DeckListViewModel.shared
    
    var body: some View {
        VStack {
            LineView()
                .padding(.bottom)
            
            Spacer()
            
            List {
                ForEach(deckViewModel.decks) { deck in
                    NavigationLink(destination: BattleRecordListView(deckName: deck.deckName)) {
                        Text(deck.deckName)
                    }
                }
            }
            .listStyle(InsetListStyle())
            
            Spacer()
        }
        .navigationTitle("使用したデッキを選択")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BattleRecordListView: View {
    
    @ObservedObject var presenter: BattleRecordPresenter
    var deckName: String
    
    init(deckName: String) {
        presenter = BattleRecordPresenter(deckName: deckName)
        self.deckName = deckName
    }
    
    var body: some View {
        VStack {
            LineView()
                .padding(.bottom)
            
            Spacer()
            
            List {
                Section {
                    ForEach(presenter.recordList) { record in
                        CellView(battleRecord: record)
                    }
                } header: {
                    Text("使用デッキ: \(deckName)")
                }
            }
            .listStyle(InsetListStyle())
            
            Spacer()
        }
        .navigationTitle("対戦成績一覧")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CellView: View {
    
    var battleRecord: BattleRecord
    
    var body: some View {
        VStack{
            HStack{
                // 相手のデッキ
                Text("相手のデッキ: \(battleRecord.opponentDeckName)")
                
                Spacer()
                
                // 先攻/後攻
                if battleRecord.isFirst {
                    Image("senkou")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                } else {
                    Image("koukou")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
            }
            HStack{
                // 取ったサイド
                Text("取ったサイド: \(battleRecord.myScore)")
                
                // 取られたサイド
                Text("取られたサイド: \(battleRecord.opponentScore)")
                
                Spacer()
                
                // 対戦結果
                if battleRecord.isWon {
                    Image("win")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                } else {
                    Image("lose")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
            }
        }
        .font(.system(size: 14))
    }
}
