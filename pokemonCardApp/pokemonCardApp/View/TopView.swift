//
//  TopView.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/03/27.
//

import SwiftUI

struct TopView: View {
    
    let navigationbarAppearance = UINavigationBarAppearance()
    
    @State private var isShowAddDeck = false
    @State private var isShowMyCollection = false
    @State private var isShowMyFavoriteCollection = false
    @State private var isShowRecords = false
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color("basic"))]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: AddDeckView(), isActive: $isShowAddDeck) {
                    EmptyView()
                }
                
                NavigationLink(destination: DeckListView(), isActive: $isShowMyCollection) {
                    EmptyView()
                }
                
                NavigationLink(destination: FavoriteDeckListView(), isActive: $isShowMyFavoriteCollection) {
                    EmptyView()
                }
                
                NavigationLink(destination: BattleRecordsMenuView(), isActive: $isShowRecords) {
                    EmptyView()
                }
            
                VStack(spacing: 0) {
                    // デッキ登録
                    ButtonView(buttonName: MultilingualDefine.add, isShowFlg: $isShowAddDeck)
                    
                    // デッキリスト
                    ButtonView(buttonName: MultilingualDefine.deckList, isShowFlg: $isShowMyCollection)
                    
                    // お気に入りリスト
                    ButtonView(buttonName: MultilingualDefine.favorite, isShowFlg: $isShowMyFavoriteCollection)

                    // 対戦成績メニュー
                    ButtonView(buttonName: MultilingualDefine.records, isShowFlg: $isShowRecords)
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    BannerView()
                        .frame(width: UIScreen.main.bounds.width, height: 50)
                }
            }
        }
    }
}

struct ButtonView: View {
    
    var buttonName: String
    @Binding var isShowFlg: Bool
    
    var body: some View {
        Button(buttonName) {
            isShowFlg = true
        }
        .font(.system(size: 20))
        .foregroundColor(Color("basic"))
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
        
        Divider()
            .frame(width: UIScreen.main.bounds.width * 0.5, height: 3, alignment: .center)
            .background(Color("blueLine"))
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
        Divider()
            .frame(width: UIScreen.main.bounds.width * 0.5, height: 3, alignment: .center)
            .background(Color("yellowLine"))
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
    }
}
