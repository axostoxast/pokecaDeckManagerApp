//
//  DeckDetailView.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/03/27.
//

import SwiftUI

struct DeckDetailView: View {
    
    var name: String = ""
    var code: String = ""
    var memo: String = ""
    
    @State var isDidCopiedCode = false
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    UIPasteboard.general.string = code
                    isDidCopiedCode = true
                }, label: {
                    Image(systemName: "doc.on.clipboard")
                })
                Text(code)
            }
            if isDidCopiedCode {
                Text("デッキコードをコピーしました")
            }
            
            
            Text(memo)
                .padding(.top)
        }
        .navigationTitle(name)
    }
}
