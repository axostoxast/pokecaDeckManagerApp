//
//  TopView.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/03/27.
//

import SwiftUI

struct TopView: View {
    
    let navigationbarAppearance = UINavigationBarAppearance()
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color("basic"))]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: AddDeckView()) {
                    Image("addNewDeck")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.08)
                }
                .padding(.bottom)
                
                NavigationLink(destination: DeckListView()) {
                    Image("myCollection")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.08)
                }
            }
        }
        .navigationTitle("ポケカアプリ")
    }
}

