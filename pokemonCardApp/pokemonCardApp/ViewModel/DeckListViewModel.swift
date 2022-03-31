//
//  DeckListViewModel.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/03/27.
//

import Foundation

class DeckListViewModel: ObservableObject {
    @Published var isShowAddView = false
    @Published var updatingDeck: Deck? = nil
    @Published var decks: [Deck] = []
    @Published var deckName = ""
    @Published var deckCode = ""
    @Published var deckMemo = ""
    @Published var deckImageData = Data()
    
    init () {
        fetchDecks()
    }
    
    func fetchDecks() {
        self.decks = Deck.fetchAllDeck()!
    }
    
    func addDeck() {
        Deck.addDeck(deckName: deckName, deckCode: deckCode, deckMemo: deckMemo, deckImageData: deckImageData)
        self.deckName = ""
        self.deckCode = ""
        self.deckMemo = ""
        self.deckImageData = Data()
        fetchDecks()
    }
    
    func updateDeck() {
        Deck.updateDeck(deck: updatingDeck!, newDeckName: self.deckName, newDeckCode: self.deckCode, newDeckMemo: self.deckMemo, newDeckImageData: self.deckImageData)
        // 初期化
        self.deckName = ""
        self.deckCode = ""
        self.deckMemo = ""
        self.deckImageData = Data()
        updatingDeck = nil
        fetchDecks()
    }
    
    func deleteDeck(deck: Deck) {
        Deck.deleteDeck(deck: deck)
        fetchDecks()
    }
    
    static let shared = DeckListViewModel()
}
