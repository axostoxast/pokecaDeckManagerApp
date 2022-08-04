//
//  EditRecordView.swift
//  pokemonCardApp
//
//  Created by zero on 2022/08/04.
//

import SwiftUI

struct EditRecordView: View {
    enum FocusField {
        case opponentDeck
        case myScore
        case opponentScore
        case memo
    }
    
    @State var record: BattleRecord
    @State var updateRecord: BattleRecord
    @ObservedObject var deckViewModel = DeckListViewModel.shared
    @ObservedObject var recordViewModel = BattleRecordListViewModel.shared
//    @StateObject var presenter: BattleRecordPresenter
    
    @State private var myDeckNameList: [String] = [MultilingualDefine.usedDeck]
    @State private var resultValue: Int
    @State private var turnValue: Int
    @State private var isPopUpPresented: Bool = false
    
    // フォーカス管理
    @FocusState private var focusState: FocusField?
    
    init(record: BattleRecord, presenter: BattleRecordPresenter) {
//        self.presenter = presenter
        self.record = record
        updateRecord = BattleRecord()
        resultValue = record.isWon ? 1 : 2
        turnValue = record.isFirst ? 1 : 2
        setUpdateRecord(record: record)
    }
    
    func setUpdateRecord(record: BattleRecord) {
        self.updateRecord.isWon = record.isWon
        self.updateRecord.isFirst = record.isFirst
        self.updateRecord.myDeckName = record.myDeckName
        self.updateRecord.opponentDeckName = record.opponentDeckName
        self.updateRecord.myScore = record.myScore
        self.updateRecord.opponentScore = record.opponentScore
        self.updateRecord.memo = record.memo
        self.updateRecord.date = record.date
    }
    
    var body: some View {
        VStack {
            LineView()
                .padding(.bottom)
            
            Spacer()
            
            ZStack {
                VStack(spacing: 0) {
                    // 勝敗
                    Picker("", selection: $resultValue) {
                        Text("Win").tag(1)
                        Text("Lose").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    .padding(.bottom)
                    
                    // 先攻/後攻
                    Picker("", selection: $turnValue) {
                        Text("First").tag(1)
                        Text("Second").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    .padding(.bottom)
                    
                    // 使用デッキ
                    HStack {
                        Text("UsedDeck")
                            .frame(width: UIScreen.main.bounds.width * 0.4, alignment: .leading)
                        
                        Text(updateRecord.myDeckName)
                            .frame(width: UIScreen.main.bounds.width * 0.4, alignment: .leading)
                    }
                    .padding(.bottom)
                    
                    // 相手デッキ
                    HStack {
                        Text("OpponentDeck")
                            .frame(width: UIScreen.main.bounds.width * 0.4, alignment: .leading)
                        
                        TextField("", text: $updateRecord.opponentDeckName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: UIScreen.main.bounds.width * 0.4, alignment: .leading)
                            .focused($focusState, equals: .opponentDeck)
                            .toolbar {
                                  ToolbarItem(placement: .keyboard) {
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
                            Text("MyPrizeCard")
                            
                            TextField("", text: $updateRecord.myScore)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 30)
                                .keyboardType(.numberPad)
                                .focused($focusState, equals: .myScore)
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.4, alignment: .leading)
                        
                        HStack {
                            Text("OpponentPrizeCard")
                            
                            TextField("", text: $updateRecord.opponentScore)
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
                        TextEditor(text: $updateRecord.memo)
                            .font(.system(size: 20))
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.2, alignment: .leading)
                            .lineLimit(nil)
                            .overlay(
                                RoundedRectangle(cornerRadius: 1)
                                    .stroke(Color("basic"), lineWidth: 2)
                            )
                            .padding(.bottom)
                            .focused($focusState, equals: .memo)
                        
                        if record.memo.isEmpty {
                            Text("Memo").opacity(0.25)
                                .font(.system(size: 20))
                                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.2, alignment: .leading)
                            
                            Spacer()
                        }
                    }
                    .padding(.bottom)
                    
                    // 登録ボタン
                    Button("Register") {
                        updateRecord.isWon = resultValue == 1 ? true : false
                        updateRecord.isFirst = turnValue == 1 ? true : false
                        
                        recordViewModel.updatingRecord = record
                        recordViewModel.isWon = updateRecord.isWon
                        recordViewModel.isFirst = updateRecord.isFirst
                        recordViewModel.myDeckName = updateRecord.myDeckName
                        recordViewModel.opponentDeckName = updateRecord.opponentDeckName
                        recordViewModel.myScore = updateRecord.myScore
                        recordViewModel.opponentScore = updateRecord.opponentScore
                        recordViewModel.memo = updateRecord.memo
                        recordViewModel.date = updateRecord.date
                        recordViewModel.updateRecord()
                        
//                        presenter.reloadData(deckName: record.myDeckName)
                        
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
                    PopUpView(isPresented: $isPopUpPresented, message: MultilingualDefine.registered)
                }
            }
            Spacer()
        }
        .foregroundColor(Color("basic"))
        .onAppear {
            deckViewModel.decks.forEach({ deck in
                myDeckNameList.append(deck.deckName)
            })
            
        }
        .navigationTitle("戦績編集")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                BannerView()
                    .frame(width: UIScreen.main.bounds.width, height: 50)
            }
        }
    }
}
