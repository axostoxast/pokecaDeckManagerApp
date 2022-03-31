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
    
    @State private var isOverlayPresented = false
    
    let textWidth = UIScreen.main.bounds.width * 0.8
    let copyIconWidth = UIScreen.main.bounds.width * 0.6
    let copyIconHeight = UIScreen.main.bounds.height * 0.035
    let imageAreaHeight = UIScreen.main.bounds.height * 0.3
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                // ライン画像
                Image("lineImage")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.05)
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
                
                // コピーアイコン
                Image("copy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: copyIconWidth, height: copyIconHeight, alignment: .trailing)
                    .onTapGesture {
                        UIPasteboard.general.string = code
                        withAnimation(.easeIn(duration: 0.2)) {
                            isOverlayPresented = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            withAnimation(.easeOut(duration: 0.1)) {
                                isOverlayPresented = false
                            }
                        }
                    }
                    .padding(.bottom)
                
                // デッキ画像
                Image(uiImage: UIImage(data: imageData) ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(width: textWidth, height: imageAreaHeight, alignment: .center)
                
                // メモ
                Text(memo)
                    .font(.system(size: 24))
                    .foregroundColor(Color("basic"))
                    .frame(width: textWidth, alignment: .leading)
                    .padding(.bottom)
                
                Spacer()
            }
            
            if isOverlayPresented {
                OverlayView(isPresented: $isOverlayPresented)
            }
        }
        .navigationTitle("MY COLLECTION")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct OverlayView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        Text("コピーしました")
            .frame(width: 200, height: 50)
            .foregroundColor(.black)
            .background(Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 0.9))
            .cornerRadius(10)
    }
}
