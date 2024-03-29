//
//  BattleRecordListViewModel.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/06/07.
//

import Foundation

class BattleRecordListViewModel: ObservableObject {
    @Published var updatingRecord: BattleRecord?
    @Published var redords: [BattleRecord] = []
    @Published var isWon = false
    @Published var isFirst = false
    @Published var myDeckName = ""
    @Published var opponentDeckName = ""
    @Published var myScore = ""
    @Published var opponentScore = ""
    @Published var memo = ""
    @Published var date = ""
    
    init () {
        fetchRecords()
    }
    
    func fetchRecords() {
        self.redords = BattleRecord.fetchAllRecord()!
    }
    
    func addRecord() {
        let battleRecordParam = BattleRecordParam(isWon: isWon, isFirst: isFirst, myDeckName: myDeckName, opponentDeckName: opponentDeckName, myScore: myScore, opponentScore: opponentScore, memo: memo, date: date)
        BattleRecord.addRecord(battleRecordParam: battleRecordParam)
        self.isWon = false
        self.isFirst = false
        self.myDeckName = ""
        self.opponentDeckName = ""
        self.myScore = ""
        self.opponentScore = ""
        self.memo = ""
        self.date = ""
        fetchRecords()
    }
    
    func updateRecord() {
        let battleRecordParam = BattleRecordParam(isWon: isWon, isFirst: isFirst, myDeckName: myDeckName, opponentDeckName: opponentDeckName, myScore: myScore, opponentScore: opponentScore, memo: memo, date: date)
        BattleRecord.updateRecord(record: updatingRecord!, battleRecordParam: battleRecordParam)
        // 初期化
        self.isWon = false
        self.isFirst = false
        self.myDeckName = ""
        self.opponentDeckName = ""
        self.myScore = ""
        self.opponentScore = ""
        self.memo = ""
        self.date = ""
        updatingRecord = nil
        fetchRecords()
    }
    
    func deleteRecord(record: BattleRecord) {
        BattleRecord.deleteRecord(record: record)
        fetchRecords()
    }
    
    static let shared = BattleRecordListViewModel()
}
