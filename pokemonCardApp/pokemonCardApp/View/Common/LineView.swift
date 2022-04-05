//
//  LineView.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/04/05.
//

import SwiftUI

struct LineView: View {
    var body: some View {
        VStack {
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
            }
            .stroke(lineWidth: 5)
            .fill(Color("blueLine"))
            .frame(width: UIScreen.main.bounds.width, height: 5)
            .padding(.top)
            
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
            }
            .stroke(lineWidth: 5)
            .fill(Color("yellowLine"))
            .frame(width: UIScreen.main.bounds.width, height: 5)
        }
    }
}
