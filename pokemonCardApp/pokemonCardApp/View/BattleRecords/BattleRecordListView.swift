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
            
            if deckViewModel.decks.count > 0 {
                List {
                    ForEach(deckViewModel.decks) { deck in
                        NavigationLink(destination: BattleRecordListView(deckName: deck.deckName)) {
                            Text(deck.deckName)
                        }
                    }
                }
                .listStyle(InsetListStyle())
            } else {
                // デッキ未登録の場合
                Text("NoDecks")
                    .font(.system(size: 20))
                    .opacity(0.5)
                
            }
            Spacer()
        }
        .navigationTitle("SelectUsedDeck")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .bottomBar) {
                BannerView()
                    .frame(width: UIScreen.main.bounds.width, height: 50)
            }
        }
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
            
            if presenter.recordList.count > 0 {
                List {
                    Section {
                        ForEach(presenter.recordList) { record in
                            CellView(battleRecord: record)
                        }
                    } header: {
                        Text("\(MultilingualDefine.usedDeck): \(deckName)")
                    }
                }
                .listStyle(InsetListStyle())
            } else {
                // 対戦成績未登録の場合
                Spacer()
                Text("NoRecords")
                    .font(.system(size: 20))
                    .opacity(0.5)
                Spacer()
            }
            
            Spacer()
        }
        .navigationTitle("RecordList")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .bottomBar) {
                BannerView()
                    .frame(width: UIScreen.main.bounds.width, height: 50)
            }
        }
    }
}

struct CellView: View {
    
    var battleRecord: BattleRecord
    
    var body: some View {
        VStack{
            HStack{
                // 相手のデッキ
                Text("\(MultilingualDefine.opponentDeck): \(battleRecord.opponentDeckName)")
                
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
                Text("\(MultilingualDefine.myPrizeCard): \(battleRecord.myScore)")
                
                // 取られたサイド
                Text("\(MultilingualDefine.opponentPrizeCard): \(battleRecord.opponentScore)")
                
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
