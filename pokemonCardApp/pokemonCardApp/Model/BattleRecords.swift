//
//  BattleRecords.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/06/06.
//

import Foundation
import RealmSwift

class BattleRecord: Object, Identifiable {
    @Persisted var useDeckName = ""
    @Persisted var opponentDeckName = ""
    @Persisted var winnerGotPoints = ""
    @Persisted var loserGotPoints = ""
}

extension BattleRecord {
    // 追加
    static func addRecord(useDeckName: String, opponentDeckName: String, winnerGotPoints: String, loserGotPoints: String) {
        let record = BattleRecord()
        record.useDeckName = useDeckName
        record.opponentDeckName = opponentDeckName
        record.winnerGotPoints = winnerGotPoints
        record.loserGotPoints = loserGotPoints
        
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            localRealm.add(record)
        }
    }
    
    // 更新
    static func updateRecord(record: BattleRecord, useDeckName: String, opponentDeckName: String, winnerGotPoints: String, loserGotPoints: String) {
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            record.useDeckName = useDeckName
            record.opponentDeckName = opponentDeckName
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
