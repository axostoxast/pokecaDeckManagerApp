//
//  BattleRecordListViewModel.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/06/07.
//

import Foundation

class BattleRecordListViewModel: ObservableObject {
    @Published var updatingRecord: BattleRecord? = nil
    @Published var redords: [BattleRecord] = []
    @Published var isWon = false
    @Published var isFirst = false
    @Published var myDeckName = ""
    @Published var opponentDeckName = ""
    @Published var myScore = ""
    @Published var opponentScore = ""
    @Published var memo = ""
    
    init () {
        fetchRecords()
    }
    
    func fetchRecords() {
        self.redords = BattleRecord.fetchAllDeck()!
    }
    
    func addRecord() {
        BattleRecord.addRecord(isWon: isWon, isFirst: isFirst, myDeckName: myDeckName, opponentDeckName: opponentDeckName, myScore: myScore, opponentScore: opponentScore, memo: memo)
        self.isWon = false
        self.isFirst = false
        self.myDeckName = ""
        self.opponentDeckName = ""
        self.myScore = ""
        self.opponentScore = ""
        self.memo = ""
        fetchRecords()
    }
    
    func updateRecord() {
        BattleRecord.updateRecord(record: updatingRecord!, isWon: isWon, isFirst: isFirst, myDeckName: myDeckName, opponentDeckName: opponentDeckName, myScore: myScore, opponentScore: opponentScore, memo: memo)
        // 初期化
        self.isWon = false
        self.isFirst = false
        self.myDeckName = ""
        self.opponentDeckName = ""
        self.myScore = ""
        self.opponentScore = ""
        self.memo = ""
        updatingRecord = nil
        fetchRecords()
    }
    
    func deleteRecord(record: BattleRecord) {
        BattleRecord.deleteDeck(record: record)
        fetchRecords()
    }
    
    static let shared = BattleRecordListViewModel()
}
