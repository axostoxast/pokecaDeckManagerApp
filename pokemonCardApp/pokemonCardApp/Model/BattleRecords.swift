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
}

extension BattleRecord {
    // 追加
    static func addRecord(isWon: Bool, isFirst: Bool, myDeckName: String, opponentDeckName: String, myScore: String, opponentScore: String, memo: String) {
        let record = BattleRecord()
        record.isWon = isWon
        record.isFirst = isFirst
        record.myDeckName = myDeckName
        record.opponentDeckName = opponentDeckName
        record.myScore = myScore
        record.opponentScore = opponentScore
        record.memo = memo
        
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            localRealm.add(record)
        }
    }
    
    // 更新
    static func updateRecord(record: BattleRecord, isWon: Bool, isFirst: Bool, myDeckName: String, opponentDeckName: String, myScore: String, opponentScore: String, memo: String) {
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            record.isWon = isWon
            record.isFirst = isFirst
            record.myDeckName = myDeckName
            record.opponentDeckName = opponentDeckName
            record.myScore = myScore
            record.opponentScore = opponentScore
            record.memo = memo
        }
    }
    
    // 取得
    static func fetchAllDeck() -> [BattleRecord]? {
        guard let localRealm = try? Realm() else { return nil }
        let records = localRealm.objects(BattleRecord.self)
        return Array(records)
    }
    
    // 削除
    static func deleteDeck(record: BattleRecord) {
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            localRealm.delete(record)
        }
    }
}
