//
//  BattleRecordListView.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/06/10.
//

import SwiftUI
import SwiftPieChart

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
                        NavigationLink(destination: BattleRecordTabView(presenter: BattleRecordPresenter(deckName: deck.deckName, deckCode: deck.deckCode), deckName: deck.deckName, deckCode: deck.deckCode)) {
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
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                BannerView()
                    .frame(width: UIScreen.main.bounds.width, height: 50)
            }
        }
    }
}

struct BattleRecordTabView: View {
    
    @StateObject var presenter: BattleRecordPresenter
    var deckName: String
    var deckCode: String
    
    @State var selectedTab = 1
    
    var body: some View {
        VStack {
            LineView()
                .padding(.bottom)
            
            Spacer()
            
            if presenter.recordList.count > 0 {
                // 画面切り替えタブ
                TabBarView(selectedTab: $selectedTab)
                
                TabView(selection: $selectedTab) {
                    RecordListView(presenter: presenter, deckName: deckName, deckCode: deckCode)
                        .tag(1)
                    
                    BattleRecordGraphView(presenter: presenter)
                        .tag(2)
                }
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
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                BannerView()
                    .frame(width: UIScreen.main.bounds.width, height: 50)
            }
        }
        .onAppear {
            presenter.reloadData(deckName: deckName, deckCode: deckCode)
        }
    }
}

struct RecordListView: View {
    
    @StateObject var presenter: BattleRecordPresenter
    var deckName: String
    var deckCode: String
    
    var body: some View {
        List {
            Section {
                ForEach(presenter.recordList) { record in
                    NavigationLink(destination: EditRecordView(record: record, presenter: presenter)) {
                        CellView(battleRecord: record)
                    }
                }
            } header: {
                Text("\(MultilingualDefine.usedDeck): \(deckName)")
            }
        }
        .listStyle(InsetListStyle())
        .onAppear {
            presenter.reloadData(deckName: deckName, deckCode: deckCode)
        }
    }
}

struct CellView: View {
    
    var battleRecord: BattleRecord
    
    var body: some View {
        VStack {
            HStack {
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
            HStack {
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

struct BattleRecordGraphView: View {
    
    @ObservedObject var presenter: BattleRecordPresenter
    
    var body: some View {
        List {
            ForEach(presenter.pieChartDataList) { data in
                Text("対\(data.opponentDeck)")
                    .foregroundColor(Color("basic"))
                CustomPieChartView(
                    values: [data.winAndFirst, data.winAndSecond, data.loseAndFirst, data.loseAndSecond],
                    names: ["勝ち(先行)", "勝ち(後行)", "負け(先行)", "負け(後行)"],
                    colors: [Color("orange"), Color("pink"), Color("blue"), Color("purple")],
                    widthFraction: 0.4,
                    innerRadiusFraction: 0.5
                )
                .frame(minHeight: UIScreen.main.bounds.width * 0.5)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(InsetListStyle())
        
        Spacer()
    }
}

struct TabBarView: View {
    @Binding var selectedTab: Int
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Image(systemName: "list.dash.header.rectangle")
                    
                Text("リスト")
            }
            .foregroundColor(selectedTab == 1 ? Color.blue : Color.gray)
            .onTapGesture {
                self.selectedTab = 1
            }
            Spacer()
            VStack {
                Image(systemName: "chart.pie")
                    
                Text("グラフ")
            }
            .foregroundColor(selectedTab == 2 ? Color.blue : Color.gray)
            .onTapGesture {
                self.selectedTab = 2
            }
            Spacer()
        }
    }
}
