//
//  DeckDetailView.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/03/27.
//

import SwiftUI

struct DeckDetailView: View {
    
    var name: String
    var code: String
    var memo: String
    var imageData: Data
    
    @State private var isPopUpPresented = false
    
    /// 表示項目のサイズ定義
    let textWidth = UIScreen.main.bounds.width * 0.8
    let emptyWidth = UIScreen.main.bounds.width * 0.6
    let copyButtonWidth = UIScreen.main.bounds.width * 0.2
    let copyButtonHeight = UIScreen.main.bounds.height * 0.03
    let imageAreaHeight = UIScreen.main.bounds.height * 0.3
    let noImageAreaWidth = UIScreen.main.bounds.width * 0.6
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                LineView()
                    .padding(.bottom)
                
                // デッキ名
                Text(name)
                    .font(.system(size: 24))
                    .foregroundColor(Color("basic"))
                    .frame(width: textWidth, alignment: .leading)
                    .padding(.bottom)
                
                // デッキコード
                Text(code)
                    .font(.system(size: 24))
                .foregroundColor(Color("basic"))
                .frame(width: textWidth, alignment: .leading)
                
                // コピーボタン
                if !code.isEmpty {
                    HStack {
                        Text("")
                            .frame(width: emptyWidth, height: copyButtonHeight, alignment: .trailing)
                        Button {
                            UIPasteboard.general.string = code
                            withAnimation(.easeIn(duration: 0.2)) {
                                isPopUpPresented = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                withAnimation(.easeOut(duration: 0.1)) {
                                    isPopUpPresented = false
                                }
                            }
                        } label: {
                            Text("コピー")
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
                
                if let image = UIImage(data: imageData) {
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
                Text(memo)
                    .font(.system(size: 24))
                    .foregroundColor(Color("basic"))
                    .frame(width: textWidth, alignment: .leading)
                    .padding(.bottom)
                
                Spacer()
            }
            
            if isPopUpPresented {
                PopUpView(isPresented: $isPopUpPresented, message: "コピーしました")
            }
        }
        // ヘッダー
        .navigationTitle("MY COLLECTION")
        .navigationBarTitleDisplayMode(.inline)
    }
}
