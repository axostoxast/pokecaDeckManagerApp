//
//  Deck.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/03/27.
//

import Foundation
import RealmSwift

class Deck: Object, Identifiable {
    @Persisted var deckName = ""
    @Persisted var deckCode = ""
    @Persisted var deckMemo = ""
    @Persisted var deckImageData = Data()
    @Persisted var isFavorite = false
}

extension Deck {
    // 追加
    static func addDeck(deckName: String, deckCode: String, deckMemo: String, deckImageData: Data, isFavorite: Bool) {
        let deck = Deck()
        deck.deckName = deckName
        deck.deckCode = deckCode
        deck.deckMemo = deckMemo
        deck.deckImageData = deckImageData
        deck.isFavorite = isFavorite
        
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            localRealm.add(deck)
        }
    }
    
    // 更新
    static func updateDeck(deck: Deck, newDeckName: String, newDeckCode: String, newDeckMemo: String, newDeckImageData: Data, isFavorite: Bool) {
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            deck.deckName = newDeckName
            deck.deckCode = newDeckCode
            deck.deckMemo = newDeckMemo
            deck.deckImageData = newDeckImageData
            deck.isFavorite = isFavorite
        }
    }
    
    // 取得
    static func fetchAllDeck() -> [Deck]? {
        guard let localRealm = try? Realm() else { return nil }
        let decks = localRealm.objects(Deck.self)
        return Array(decks)
    }
    
    // お気に入り取得
    static func fetchFavoriteDeck() -> [Deck]? {
        guard let localRealm = try? Realm() else { return nil }
        let decks = localRealm.objects(Deck.self).filter("isFavorite == true")
        return Array(decks)
    }
    
    // 削除
    static func deleteDeck(deck: Deck) {
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            localRealm.delete(deck)
        }
    }
}
