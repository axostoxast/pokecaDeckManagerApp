//
//  AddDeckView.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/03/27.
//

import SwiftUI
import PhotosUI
import os
import SwiftUIPHPicker

struct AddDeckView: View {
    
    enum FocusField {
        case name
        case code
        case memo
    }
    
    @State private var image: UIImage = UIImage()
    @State private var isShowPHPicker: Bool = false
    @State private var isPickedImage: Bool = false
    @State private var isPopUpSuccess: Bool = false
    
    // フォーカス管理
    @FocusState private var focusState : FocusField?
    
    /// 入力項目のサイズ定義
    let textFieldWidth = UIScreen.main.bounds.width * 0.8
    let memoFieldHeight = UIScreen.main.bounds.height * 0.25
    let selectImageButtonWidth = UIScreen.main.bounds.width * 0.4
    let selectImageButtonHeight = UIScreen.main.bounds.height * 0.04
    let registerButtonWidth = UIScreen.main.bounds.width * 0.2
    let registerButtonHeight = UIScreen.main.bounds.height * 0.04
    
    static var config: PHPickerConfiguration {
        var config = PHPickerConfiguration()
        config.filter = .images
        return config
    }
    
    @ObservedObject var viewModel = DeckListViewModel.shared
    @ObservedObject var presenter = AddDeckPresenter()
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                LineView()
                    .padding(.bottom)
                
                // デッキ名
                TextField("DeckName", text: $viewModel.deckName)
                    .frame(width: textFieldWidth)
                    .font(.system(size: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 1)
                            .stroke(Color("basic"), lineWidth: 2)
                    )
                    .padding(.vertical)
                    .focused($focusState, equals: .name)
                    .toolbar{
                          ToolbarItem(placement: .keyboard){
                              Button(action: {
                                  focusState = nil
                              }, label: {
                                  Text("Close")
                              })
                          }
                    }
                
                // デッキコード
                TextField("DeckCode", text: $viewModel.deckCode)
                    .frame(width: textFieldWidth)
                    .font(.system(size: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 1)
                            .stroke(Color("basic"), lineWidth: 2)
                    )
                    .padding(.bottom)
                    .focused($focusState, equals: .code)
                
                // 画像
                if !isPickedImage {
                    Button(action: {
                        isShowPHPicker.toggle()
                    }, label: {
                        Text("SelectImage")
                            .foregroundColor(Color("basic"))
                    })
                    .frame(width: selectImageButtonWidth, height: selectImageButtonHeight, alignment: .center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("blueLine"), lineWidth: 2)
                    )
                    .padding(.bottom)
                } else {
                    ZStack(alignment: .leading) {
                        Text("Selected")
                            .frame(width: textFieldWidth, alignment: .leading)
                        
                        Button(action: {
                            self.image = UIImage()
                            isShowPHPicker = false
                            isPickedImage = false
                        }, label: {
                            Image(systemName: "trash")
                        })
                        .padding(EdgeInsets(
                            top: 0, leading: UIScreen.main.bounds.width * 0.2, bottom: 0, trailing: 0
                        ))
                    }
                    .padding(.bottom)
                }
                
                // メモ
                ZStack(alignment: .top) {
                    TextEditor(text: $viewModel.deckMemo)
                        .font(.system(size: 20))
                        .frame(width: textFieldWidth, height: memoFieldHeight, alignment: .center)
                        .lineLimit(nil)
                        .overlay(
                            RoundedRectangle(cornerRadius: 1)
                                .stroke(Color("basic"), lineWidth: 2)
                        )
                        .padding(.bottom)
                        .focused($focusState, equals: .memo)
                    
                    if viewModel.deckMemo.isEmpty {
                        Text("Memo").opacity(0.25)
                            .font(.system(size: 20))
                            .frame(width: textFieldWidth, height: memoFieldHeight, alignment: .leading)
                        
                        Spacer()
                    }
                }
                .padding(.bottom)
                
                // 登録ボタン
                Button(action: {
                    presenter.addDeck()
                    // 登録成功メッセージ表示
                    withAnimation(.easeIn(duration: 0.2)) {
                        isPopUpSuccess = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation(.easeOut(duration: 0.1)) {
                            isPopUpSuccess = false
                        }
                    }
                }) {
                    Text("Register")
                        .foregroundColor(Color("basic"))
                }
                .alert("エラー", isPresented: $presenter.isError, actions: {}, message: {
                    Text(presenter.errorMessage)
                })
                .frame(width: registerButtonWidth, height: registerButtonHeight, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("blueLine"), lineWidth: 2)
                )
                
                Spacer()
            }
            
            // 登録成功メッセージ
            if isPopUpSuccess {
                PopUpView(isPresented: $isPopUpSuccess, message: MultilingualDefine.registered)
            }
        }
        .ignoresSafeArea(.keyboard)
        // 画像選択画面
        .sheet(isPresented: $isShowPHPicker) {
            SwiftUIPHPicker(configuration: AddDeckView.config) { results in
                for result in results {
                    let itemProvider = result.itemProvider
                    if itemProvider.canLoadObject(ofClass: UIImage.self) {
                        itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                            if let image = image as? UIImage {
                                DispatchQueue.main.async {
                                    self.image = image
                                    self.isPickedImage = true
                                    viewModel.deckImageData = self.image.jpegData(compressionQuality: 1) ?? Data()
                                }
                            }
                            if error != nil {
                                OSLog.ui.log("画像選択に失敗")
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Add")
        .navigationBarTitleDisplayMode(.inline)
    }
}
