//
//  DeckListViewModel.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/03/27.
//

import Foundation

class DeckListViewModel: ObservableObject {
    @Published var isShowAddView = false
    @Published var updatingDeck: Deck?
    @Published var decks: [Deck] = []
    @Published var favoriteDecks: [Deck] = []
    @Published var deckName = ""
    @Published var deckCode = ""
    @Published var deckMemo = ""
    @Published var deckImageData = Data()
    @Published var isFavorite = false
    
    init () {
        fetchDecks()
    }
    
    func fetchDecks() {
        self.decks = Deck.fetchAllDeck()!
        self.favoriteDecks = Deck.fetchFavoriteDeck()!
    }
    
    func addDeck() {
        let deckParam = DeckParam(deckName: deckName, deckCode: deckCode, deckMemo: deckMemo, deckImageData: deckImageData, isFavorite: isFavorite)
        Deck.addDeck(deckParam: deckParam)
        self.deckName = ""
        self.deckCode = ""
        self.deckMemo = ""
        self.deckImageData = Data()
        self.isFavorite = false
        fetchDecks()
    }
    
    func updateDeck() {
        let deckParam = DeckParam(deckName: deckName, deckCode: deckCode, deckMemo: deckMemo, deckImageData: deckImageData, isFavorite: isFavorite)
        Deck.updateDeck(deck: updatingDeck!, deckParam: deckParam)
        // 初期化
        self.deckName = ""
        self.deckCode = ""
        self.deckMemo = ""
        self.deckImageData = Data()
        self.isFavorite = false
        updatingDeck = nil
        fetchDecks()
    }
    
    func deleteDeck(deck: Deck) {
        Deck.deleteDeck(deck: deck)
        fetchDecks()
    }
    
    static let shared = DeckListViewModel()
}
