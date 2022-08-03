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
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color("basic"))]
    }
    
    var body: some View {
        VStack {
            LineView()
                .padding(.bottom)
            
            Spacer()
            
            ZStack {
                NavigationLink(destination: RegisterRecordView(), isActive: $isShowRegisterRecord) {
                    EmptyView()
                }
                
                NavigationLink(destination: SelectDeckForRecordView(), isActive: $isShowRecordList) {
                    EmptyView()
                }
            
                VStack(spacing: 0) {
                    // 対戦成績記録
                    ButtonView(buttonName: MultilingualDefine.register, isShowFlg: $isShowRegisterRecord)
                    
                    // 対戦成績一覧
                    ButtonView(buttonName: MultilingualDefine.recordList, isShowFlg: $isShowRecordList)
                }
            }
            Spacer()
        }
        .navigationTitle("Records")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                BannerView()
                    .frame(width: UIScreen.main.bounds.width, height: 50)
            }
        }
    }
}
