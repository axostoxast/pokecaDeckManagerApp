//
//  BattleRecordPresenter.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/06/22.
//

import Foundation
import SwiftUI

class BattleRecordPresenter: ObservableObject {
    var recordList: [BattleRecord] = []
    @ObservedObject var recordViewModel = BattleRecordListViewModel.shared
    
    init(deckName: String) {
        recordList = recordViewModel.redords.filter { $0.myDeckName == deckName }
    }
}
