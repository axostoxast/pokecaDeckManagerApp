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
    @State private var isPopUpPresented: Bool = false
    
    @FocusState private var focusState : FocusField?
    
    let textFieldWidth = UIScreen.main.bounds.width * 0.8
    
    static var config: PHPickerConfiguration {
        var config = PHPickerConfiguration()
        config.filter = .images
        return config
    }
    
    @ObservedObject var viewModel = DeckListViewModel.shared
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                LineView()
                    .padding(.bottom)
                
                TextField("デッキ名", text: $viewModel.deckName)
                    .frame(width: textFieldWidth)
                    .font(.system(size: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 1)
                            .stroke(Color("basic"), lineWidth: 2)
                    )
                    .padding(.bottom)
                    .focused($focusState, equals: .name)
                    .toolbar{
                          ToolbarItem(placement: .keyboard){
                              Button(action: {
                                  focusState = nil
                              }, label: {
                                  Text("閉じる")
                              })
                          }
                    }
                
                TextField("デッキコード", text: $viewModel.deckCode)
                    .frame(width: textFieldWidth)
                    .font(.system(size: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 1)
                            .stroke(Color("basic"), lineWidth: 2)
                    )
                    .padding(.bottom)
                    .focused($focusState, equals: .code)
                
                if !isPickedImage {
                    Button(action: {
                        isShowPHPicker.toggle()
                    }, label: {
                        Text("デッキ画像を選択")
                    })
                    .frame(width: textFieldWidth, alignment: .leading)
                    .padding(.bottom)
                } else {
                    ZStack(alignment: .leading) {
                        Text("選択済み")
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
                
                ZStack(alignment: .top) {
                    TextEditor(text: $viewModel.deckMemo)
                        .font(.system(size: 20))
                        .frame(width: textFieldWidth, height: UIScreen.main.bounds.width * 0.4, alignment: .center)
                        .lineLimit(nil)
                        .overlay(
                            RoundedRectangle(cornerRadius: 1)
                                .stroke(Color("basic"), lineWidth: 2)
                        )
                        .padding(.bottom)
                        .focused($focusState, equals: .memo)
                    
                    if viewModel.deckMemo.isEmpty {
                        Text("メモ").opacity(0.25)
                            .font(.system(size: 20))
                            .frame(width: textFieldWidth, height: UIScreen.main.bounds.width * 0.4, alignment: .leading)
                        
                        Spacer()
                    }
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.addDeck()
                    // 登録成功メッセージ表示
                    withAnimation(.easeIn(duration: 0.2)) {
                        isPopUpPresented = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation(.easeOut(duration: 0.1)) {
                            isPopUpPresented = false
                        }
                    }
                }) {
                    Text("登録")
                }
                Spacer()
            }
            
            if isPopUpPresented {
                PopUpView(isPresented: $isPopUpPresented, message: "登録しました")
            }
        }
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
                                print("画像選択に失敗")
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("ADD NEW DECK")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}
