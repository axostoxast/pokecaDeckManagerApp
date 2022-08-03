//
//  DeckListPresenter.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/08/03.
//

import Foundation

class DeckListPresenter: ObservableObject {
    func updateDeck(deck: Deck, deckParam: DeckParam) {
        Deck.updateDeck(deck: deck, deckParam: deckParam)
    }
}
