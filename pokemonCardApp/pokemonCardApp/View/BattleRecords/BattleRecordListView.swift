//
//  BattleRecordListView.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/06/10.
//

import SwiftUI

struct BattleRecordListView: View {
    
    @ObservedObject var recordViewModel = BattleRecordListViewModel.shared
    
    var body: some View {
        List {
            ForEach(0 ..< recordViewModel.redords.count) { index in
                CellView(battleRecord: recordViewModel.redords[index])
            }
        }
    }
}

struct CellView: View {
    
    var battleRecord: BattleRecord
    
    var body: some View {
        VStack{
            HStack{
                // 使ったデッキ
                Text("使ったデッキ: \(battleRecord.myDeckName)")
                
                Spacer()
                
                // 戦績
                if battleRecord.isWon {
                    Image("win")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                } else {
                    Image("lose")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                }
            }
            
            HStack{
                // 相手のデッキ
                Text("相手のデッキ: \(battleRecord.opponentDeckName)")
                
                Spacer()
                
                // 先攻/後攻
                if battleRecord.isFirst {
                    Image("senkou")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                } else {
                    Image("koukou")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                }
            }
            HStack{
                // 取ったサイド
                Text("取ったサイド: \(battleRecord.myScore)")
                
                // 取られたサイド
                Text("取られたサイド: \(battleRecord.opponentScore)")
                
                Spacer()
            }
        }
        .font(.system(size: 14))
    }
}
