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

class DeckParam {
    var deckName = ""
    var deckCode = ""
    var deckMemo = ""
    var deckImageData = Data()
    var isFavorite = false
    
    init(
        deckName: String = "",
        deckCode: String = "",
        deckMemo: String = "",
        deckImageData: Data = Data(),
        isFavorite: Bool = false
    ) {
        self.deckName = deckName
        self.deckCode = deckCode
        self.deckMemo = deckMemo
        self.deckImageData = deckImageData
        self.isFavorite = isFavorite
    }
}

extension Deck {
    // 追加
    static func addDeck(deckParam: DeckParam) {
        let deck = Deck()
        deck.deckName = deckParam.deckName
        deck.deckCode = deckParam.deckCode
        deck.deckMemo = deckParam.deckMemo
        deck.deckImageData = deckParam.deckImageData
        deck.isFavorite = deckParam.isFavorite
        
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            localRealm.add(deck)
        }
    }
    
    // 更新
    static func updateDeck(deck: Deck, deckParam: DeckParam) {
        guard let localRealm = try? Realm() else { return }
        try? localRealm.write {
            deck.deckName = deckParam.deckName
            deck.deckCode = deckParam.deckCode
            deck.deckMemo = deckParam.deckMemo
            deck.deckImageData = deckParam.deckImageData
            deck.isFavorite = deckParam.isFavorite
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
