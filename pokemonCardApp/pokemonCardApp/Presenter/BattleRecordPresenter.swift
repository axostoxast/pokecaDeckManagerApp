//
//  BattleRecordPresenter.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/06/22.
//

import Foundation
import SwiftUI

class BattleRecordPresenter: ObservableObject {
    @Published var recordList: [BattleRecord] = []
    @Published var pieChartDataList: [PieChartData] = []
    @ObservedObject var recordViewModel = BattleRecordListViewModel.shared
    
    init(deckName: String) {
        recordList = recordViewModel.redords.filter { $0.myDeckName == deckName }
        setPieChartData()
    }
    
    func reloadData(deckName: String) {
        recordList = recordViewModel.redords.filter { $0.myDeckName == deckName }
        setPieChartData()
    }
    
    func setPieChartData() {
        pieChartDataList = []
        for record in self.recordList {
            // 対戦相手が重複している場合は結果をインクリメント
            if let index = self.pieChartDataList.firstIndex(where: { $0.opponentDeck == record.opponentDeckName }) {
                if record.isWon {
                    if record.isFirst {
                        pieChartDataList[index].winAndFirst += 1
                    } else {
                        pieChartDataList[index].winAndSecond += 1
                    }
                } else {
                    if record.isFirst {
                        pieChartDataList[index].loseAndFirst += 1
                    } else {
                        pieChartDataList[index].loseAndSecond += 1
                    }
                }
            // 対戦相手が重複していない場合はリストに追加
            } else {
                var data: PieChartData
                if record.isWon {
                    data = PieChartData(opponentDeck: record.opponentDeckName, winAndFirst: record.isFirst ? 1 : 0, winAndSecond: record.isFirst ? 0 : 1)
                    
                } else {
                    data = PieChartData(opponentDeck: record.opponentDeckName, loseAndFirst: record.isFirst ? 1 : 0, loseAndSecond: record.isFirst ? 0 : 1)
                }
                self.pieChartDataList.append(data)
            }
        }
        
    }
}

class PieChartData: Identifiable {
    var opponentDeck: String = ""
    var winAndFirst: Int = 0
    var winAndSecond: Int = 0
    var loseAndFirst: Int = 0
    var loseAndSecond: Int = 0
    
    init (
        opponentDeck: String,
        winAndFirst: Int = 0,
        winAndSecond: Int = 0,
        loseAndFirst: Int = 0,
        loseAndSecond: Int = 0
    ) {
        self.opponentDeck = opponentDeck
        self.winAndFirst = winAndFirst
        self.winAndSecond = winAndSecond
        self.loseAndFirst = loseAndFirst
        self.loseAndSecond = loseAndSecond
    }
}
