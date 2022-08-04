//
//  BattleRecords.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/06/06.
//

import Foundation
import RealmSwift

class BattleRecord: Object, Identifiable {
    @Persisted var isWon = false
    @Persisted var isFirst = false
    @Persisted var myDeckName = ""
    @Persisted var opponentDeckName = ""
    @Persisted var myScore = ""
    @Persisted var opponentScore = ""
    @Persisted var memo = ""
    @Persisted var date = ""
}

class BattleRecordParam {
    var isWon = false
    var isFirst = false
    var myDeckName = ""
    var opponentDeckName = ""
    var myScore = ""
    var opponentScore = ""
    var memo = ""
    var date = ""
    
    init(
        isWon: Bool = false,
        isFirst: Bool = false,
        myDeckName: String = "",
        opponentDeckName: String = "",
        myScore: String = "",
        opponentScore: String = "",
        memo: String = "",
        date: String = ""
    ) {
        self.isWon = isWon
        self.isFirst = isFirst
        self.myDeckName = myDeckName
        self.opponentDeckName = opponentDeckName
        self.myScore = myScore
        self.opponentScore = opponentScore
        self.memo = memo
        self.date = date
    }
}

extension BattleRecord {
    // 追加
    static func addRecord(battleRecordParam: BattleRecordParam) {
        let record = BattleRecord()
        record.isWon = battleRecordParam.isWon
        record.isFirst = battleRecordParam.isFirst
        record.myDeckName = battleRecordParam.myDeckName
        record.opponentDeckName = battleRecordParam.opponentDeckName
        record.myScore = battleRecordParam.myScore
        record.opponentScore = battleRecordParam.opponentScore
        record.memo = battleRecordParam.memo
        record.date = battleRecordParam.date
        
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            localRealm.add(record)
        }
    }
    
    // 更新
    static func updateRecord(record: BattleRecord, battleRecordParam: BattleRecordParam) {
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            record.isWon = battleRecordParam.isWon
            record.isFirst = battleRecordParam.isFirst
            record.myDeckName = battleRecordParam.myDeckName
            record.opponentDeckName = battleRecordParam.opponentDeckName
            record.myScore = battleRecordParam.myScore
            record.opponentScore = battleRecordParam.opponentScore
            record.memo = battleRecordParam.memo
            record.date = battleRecordParam.date
        }
    }
    
    // 取得
    static func fetchAllRecord() -> [BattleRecord]? {
        guard let localRealm = try? Realm() else { return nil }
        let records = localRealm.objects(BattleRecord.self)
        return Array(records)
    }
    
    // 削除
    static func deleteRecord(record: BattleRecord) {
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            localRealm.delete(record)
        }
    }
}
