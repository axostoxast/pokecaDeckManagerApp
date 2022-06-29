//
//  AddDeckPresenter.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/06/25.
//

import Foundation
import SwiftUI

enum AddDeckResult: Int {
    case success = 0
    case deckNameEmpty = 1
    case deckCodeEmpty = 2
}

class AddDeckPresenter: ObservableObject {
    
    @ObservedObject var viewModel = DeckListViewModel.shared
    var isError: Bool = false
    var errorMessage = ""
    
    func addDeck() {
        isError = false
        if viewModel.deckName.isEmpty {
            isError = true
            errorMessage = "デッキ名を入力してください"
        } else if viewModel.deckCode.isEmpty {
            isError = true
            errorMessage = "デッキコードを入力してください"
        } else {
            viewModel.addDeck()
        }
    }
}
