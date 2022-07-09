//
//  PopUpView.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/04/05.
//

import SwiftUI

struct PopUpView: View {
    @Binding var isPresented: Bool
    var message: String
    
    var body: some View {
        Text(message)
            .frame(width: 200, height: 50)
            .foregroundColor(.black)
            .background(Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 0.9))
            .cornerRadius(10)
    }
}
