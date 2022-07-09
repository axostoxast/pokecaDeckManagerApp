//
//  MultilingualDefine.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/07/10.
//

import Foundation

public struct MultilingualDefine {
    // トップ画面
    static let add: String = NSLocalizedString("Add", comment: "Add")
    static let deckList: String = NSLocalizedString("DeckList", comment: "DeckList")
    static let favorite: String = NSLocalizedString("Favorite", comment: "Favorite")
    static let records: String = NSLocalizedString("Records", comment: "Records")
    
    // デッキ登録画面
    static let registered: String = NSLocalizedString("Registered", comment: "Registered")
    
    // 対戦成績メニュー画面
    static let register: String = NSLocalizedString("RegisterRecord", comment: "RegisterRecord")
    static let recordList: String = NSLocalizedString("RecordList", comment: "RecordList")
    
    // 対戦成績画面
    static let usedDeck: String = NSLocalizedString("UsedDeck", comment: "UsedDeck")
    static let opponentDeck: String = NSLocalizedString("OpponentDeck", comment: "OpponentDeck")
    static let myPrizeCard: String = NSLocalizedString("MyPrizeCard", comment: "MyPrizeCard")
    static let opponentPrizeCard: String = NSLocalizedString("OpponentPrizeCard", comment: "OpponentPrizeCard")
}
