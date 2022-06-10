//
//  BattleRecordsMenuView.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/06/06.
//

import SwiftUI

struct BattleRecordsMenuView: View {
    
    @State private var isShowRegisterRecord = false
    @State private var isShowRecordList = false
    
    // Localizationから多言語取得
    private let register: String = NSLocalizedString("RegisterRecord", comment: "RegisterRecord")
    private let list: String = NSLocalizedString("RecordList", comment: "RecordList")
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color("basic"))]
    }
    
    var body: some View {
        ZStack{
            NavigationLink(destination:RegisterRecordView(), isActive: $isShowRegisterRecord) {
                EmptyView()
            }
            
            NavigationLink(destination:BattleRecordListView(), isActive: $isShowRecordList) {
                EmptyView()
            }
        
            VStack(spacing: 0) {
                // 対戦成績記録
                ButtonView(buttonName: register, isShowFlg: $isShowRegisterRecord)
                
                // 対戦成績一覧
                ButtonView(buttonName: list, isShowFlg: $isShowRecordList)
            }
        }
        .navigationTitle("Records")
        .navigationBarTitleDisplayMode(.inline)
    }
}
