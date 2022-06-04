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
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color("basic"))]
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                NavigationLink(destination:AddDeckView(), isActive: $isShowAddDeck) {
                    EmptyView()
                }
                
                NavigationLink(destination:DeckListView(), isActive: $isShowMyCollection) {
                    EmptyView()
                }
                
                NavigationLink(destination:FavoriteDeckListView(), isActive: $isShowMyFavoriteCollection) {
                    EmptyView()
                }
            
                VStack(spacing: 0) {
                    // デッキ登録
                    Group {
                        Button("Add") {
                            isShowAddDeck = true
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
                    
                    // デッキリスト
                    Group {
                        Button("List") {
                            isShowMyCollection = true
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
                    
                    // お気に入りリスト
                    Group {
                        Button("Favorite") {
                            isShowMyFavoriteCollection = true
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
                    }
                }
            }
        }
        .navigationTitle("ポケカアプリ")
    }
}

