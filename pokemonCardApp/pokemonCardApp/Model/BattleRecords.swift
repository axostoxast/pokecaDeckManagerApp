//
//  BattleRecords.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/06/06.
//

import Foundation
import RealmSwift

class BattleRecord: Object, Identifiable {
    @Persisted var winnerDeckName = ""
    @Persisted var loserDeckName = ""
    @Persisted var winnerGotPoints = ""
    @Persisted var loserGotPoints = ""
}

extension BattleRecord {
    // 追加
    static func addRecord(winnerDeckName: String, loserDeckName: String, winnerGotPoints: String, loserGotPoints: String) {
        let record = BattleRecord()
        record.winnerDeckName = winnerDeckName
        record.loserDeckName = loserDeckName
        record.winnerGotPoints = winnerGotPoints
        record.loserGotPoints = loserGotPoints
        
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            localRealm.add(record)
        }
    }
    
    // 更新
    static func updateRecord(record: BattleRecord, winnerDeckName: String, loserDeckName: String, winnerGotPoints: String, loserGotPoints: String) {
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            record.winnerDeckName = winnerDeckName
            record.loserDeckName = loserDeckName
            record.winnerGotPoints = winnerGotPoints
            record.loserGotPoints = loserGotPoints
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
