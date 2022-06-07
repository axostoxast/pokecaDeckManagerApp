//
//  RegisterRecordView.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/06/07.
//

import SwiftUI

struct RegisterRecordView: View {
    
    enum FocusField {
        case opponentDeck
        case myScore
        case opponentScore
        case memo
    }
    
    @ObservedObject var deckViewModel = DeckListViewModel.shared
    @ObservedObject var recordViewModel = BattleRecordListViewModel.shared
    
    @State private var myDeckNameList: [String] = ["使用デッキ"]
    @State private var resultValue = 1
    @State private var turnValue = 1
    @State private var isPopUpPresented: Bool = false
    
    // フォーカス管理
    @FocusState private var focusState : FocusField?
    
    var body: some View {
        ZStack{
            VStack(spacing: 0) {
                // 勝敗
                Picker("", selection: $resultValue) {
                    Text("勝ち").tag(1)
                    Text("負け").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: UIScreen.main.bounds.width * 0.8)
                .padding(.bottom)
                
                // 先攻/後攻
                Picker("", selection: $turnValue) {
                    Text("先攻").tag(1)
                    Text("後攻").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: UIScreen.main.bounds.width * 0.8)
                .padding(.bottom)
                
                // 使用デッキ
                HStack {
                    Text("使用デッキ")
                        .frame(width: UIScreen.main.bounds.width * 0.4, alignment: .leading)
                    
                    Picker(selection: $recordViewModel.myDeckName, label: Text("勝利デッキ")) {
                        ForEach(myDeckNameList, id: \.self) { value in
                            Text(value).tag(value)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: UIScreen.main.bounds.width * 0.4, alignment: .leading)
                }
                .padding(.bottom)
                
                // 相手デッキ
                HStack {
                    Text("相手デッキ")
                        .frame(width: UIScreen.main.bounds.width * 0.4, alignment: .leading)
                    
                    TextField("", text: $recordViewModel.opponentDeckName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: UIScreen.main.bounds.width * 0.4, alignment: .leading)
                        .focused($focusState, equals: .opponentDeck)
                        .toolbar{
                              ToolbarItem(placement: .keyboard){
                                  Button(action: {
                                      focusState = nil
                                  }, label: {
                                      Text("Close")
                                  })
                              }
                        }
                }
                .padding(.bottom)
                
                // サイド数
                HStack {
                    HStack {
                        Text("取ったサイド")
                        
                        TextField("", text: $recordViewModel.myScore)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 30)
                            .keyboardType(.numberPad)
                            .focused($focusState, equals: .myScore)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.4, alignment: .leading)
                    
                    HStack {
                        Text("取られたサイド")
                        
                        TextField("", text: $recordViewModel.opponentScore)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 30)
                            .keyboardType(.numberPad)
                            .focused($focusState, equals: .opponentScore)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.4, alignment: .trailing)
                }
                .padding(.bottom)
                
                // メモ
                ZStack(alignment: .top) {
                    TextEditor(text: $recordViewModel.memo)
                        .font(.system(size: 20))
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.2, alignment: .leading)
                        .lineLimit(nil)
                        .overlay(
                            RoundedRectangle(cornerRadius: 1)
                                .stroke(Color("basic"), lineWidth: 2)
                        )
                        .padding(.bottom)
                        .focused($focusState, equals: .memo)
                    
                    if recordViewModel.memo.isEmpty {
                        Text("Memo").opacity(0.25)
                            .font(.system(size: 20))
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.2, alignment: .leading)
                        
                        Spacer()
                    }
                }
                .padding(.bottom)
                
                // 登録ボタン
                Button("登録") {
                    if resultValue == 1 {
                        recordViewModel.isWon = true
                    }
                    if resultValue == 1 {
                        recordViewModel.isFirst = true
                    }
                    recordViewModel.addRecord()
                    
                    // 登録成功メッセージ表示
                    withAnimation(.easeIn(duration: 0.2)) {
                        isPopUpPresented = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation(.easeOut(duration: 0.1)) {
                            isPopUpPresented = false
                        }
                    }
                }
                .font(.system(size: 20))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
                
                Divider()
                    .frame(width: UIScreen.main.bounds.width * 0.2, height: 3, alignment: .center)
                    .background(Color("blueLine"))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0))
                Divider()
                    .frame(width: UIScreen.main.bounds.width * 0.2, height: 3, alignment: .center)
                    .background(Color("yellowLine"))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
            }
            
            // 登録成功メッセージ
            if isPopUpPresented {
                PopUpView(isPresented: $isPopUpPresented, message: "Registered")
            }
        }
        .foregroundColor(Color("basic"))
        .onAppear {
            deckViewModel.decks.forEach({ deck in
                myDeckNameList.append(deck.deckName)
            })
            
        }
        .navigationTitle("RegisterRecord")
        .navigationBarTitleDisplayMode(.inline)
    }
}
