//
//  DeckDetailView.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/03/27.
//

import SwiftUI

struct DeckDetailView: View {
    
    @State var deck: Deck
    @State private var isPopUpPresented = false
    @State private var isShowEditView = false
    
    /// 表示項目のサイズ定義
    let textWidth = UIScreen.main.bounds.width * 0.8
    let emptyWidth = UIScreen.main.bounds.width * 0.6
    let copyButtonWidth = UIScreen.main.bounds.width * 0.2
    let copyButtonHeight = UIScreen.main.bounds.height * 0.03
    let imageAreaHeight = UIScreen.main.bounds.height * 0.3
    let noImageAreaWidth = UIScreen.main.bounds.width * 0.6
    
    var body: some View {
        ZStack {
            // 編集画面遷移
            NavigationLink(destination: EditDeckView(deck: deck), isActive: $isShowEditView){
                EmptyView()
            }
            
            VStack(alignment: .center) {
                LineView()
                    .padding(.bottom)
                
                // デッキ名
                Text(deck.deckName)
                    .font(.system(size: 24))
                    .foregroundColor(Color("basic"))
                    .frame(width: textWidth, alignment: .leading)
                    .padding(.bottom)
                
                // デッキコード
                Text(deck.deckCode)
                    .font(.system(size: 24))
                .foregroundColor(Color("basic"))
                .frame(width: textWidth, alignment: .leading)
                
                // コピーボタン
                if !deck.deckCode.isEmpty {
                    HStack {
                        Text("")
                            .frame(width: emptyWidth, height: copyButtonHeight, alignment: .trailing)
                        Button {
                            UIPasteboard.general.string = deck.deckCode
                            withAnimation(.easeIn(duration: 0.2)) {
                                isPopUpPresented = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                withAnimation(.easeOut(duration: 0.1)) {
                                    isPopUpPresented = false
                                }
                            }
                        } label: {
                            Text("Copy")
                                .foregroundColor(Color("basic"))
                        }
                        .frame(width: copyButtonWidth, height: copyButtonHeight, alignment: .center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color("blueLine"), lineWidth: 2)
                        )
                        .padding(.bottom)
                    }
                }
                
                if let image = UIImage(data: deck.deckImageData) {
                    // デッキ画像
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: textWidth, height: imageAreaHeight, alignment: .center)
                } else {
                    // 画像がなければデフォルト画像を表示
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: noImageAreaWidth, height: imageAreaHeight, alignment: .center)
                }
                
                // メモ
                Text(deck.deckMemo)
                    .font(.system(size: 24))
                    .foregroundColor(Color("basic"))
                    .frame(width: textWidth, alignment: .leading)
                    .padding(.bottom)
                
                Spacer()
            }
            
            if isPopUpPresented {
                PopUpView(isPresented: $isPopUpPresented, message: "Copied")
            }
        }
        // ヘッダー
        .navigationTitle(deck.deckName)
        .navigationBarItems(
            trailing: Button {
                isShowEditView = true
            } label: {
                Text("Edit")
            }
        )
        .navigationBarTitleDisplayMode(.inline)
    }
}
