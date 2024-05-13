//
//  InputPrimaryView.swift
//  UniService
//
//  Created by Admin on 19/01/2024.
//

import SwiftUI

enum InputType {
    case email
    case password
    
    var placeHolder:String{
        switch self {
        case .email:
            "email".localized()
        case .password:
            "enter_password".localized()
        }
    }
    
    var title:String{
        switch self {
        case .email:
            "login_information".localized()
        case .password:
            "password".localized()
        }
    }
    
    var field:Field {
        switch self {
        case .email:
            return .email
        case .password:
            return .password
        }
    }
    
    var keyboardType:UIKeyboardType {
        switch self {
        case .email:
            return .default
        case .password:
            return .default
        }
    }
    
    var returnKeyboard:SubmitLabel {
        switch self {
        case .email:
            return .done
        case .password:
            return .done
        }
    }
}


enum Field: Int, Hashable {
    case email, password
}

struct PrimaryTextField: View {
   
    var inputType:InputType = .email
    @Binding var isSecured:Bool
    @Binding var inputText:String
    @Binding var validError:String
    @FocusState var focusState:Field? 
    var onPressed : (() -> Void)? = nil
    var onChanged : ((String) -> Void)? = nil
    var onSubmit : (() -> Void)? = nil
    
    var body: some View {
        
        VStack{
            
            HStack {
                Text(inputType.title)
                    .frame(minWidth: 100, maxWidth: UIScreen.screenWidth - 32,alignment: .leading)
                    .font(.paragraph2Regular())
                    .foregroundColor(.text100)
                Spacer()
            }
            
            HStack{
                Group {
                    if isSecured {
                        SecureField(inputType.placeHolder,text: $inputText)
                            .onChange(of: inputText, perform: { value in
                                onChanged?(value)
                            })
                            .onSubmit {
                                onSubmit?()
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                onPressed?()
                                focusState = inputType.field
                            })
                            .keyboardType(inputType.keyboardType)
                            .submitLabel(inputType.returnKeyboard)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .font(.paragraph2Regular())
                            .foregroundColor(.text100)
                            .focused($focusState,equals: inputType.field)
                        
                    } else {
                        TextField(inputType.placeHolder, text: $inputText)
                            .onChange(of: inputText, perform: { value in
                                onChanged?(value)
                            })
                            .onSubmit {
                                onSubmit?()
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                onPressed?()
                                focusState = inputType.field
                            })
                            .keyboardType(.default)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .font(.paragraph2Regular())
                            .foregroundColor(.text100)
                            .focused($focusState,equals: inputType.field)
                    }
                }
                
                if inputType == .password {
                    Button(action: {
                        isSecured.toggle()
                    }) {
                        Image(isSecured ? "ic_eye_none" : "ic_eye")
                    .padding(.horizontal, 12)
                   }
                }
            }
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,maxWidth: .infinity, minHeight: 44)
            .background(RoundedRectangle(cornerRadius: 8).fill(.gray16))
           
            if !validError.isEmpty {
                
                HStack {
                    Text(validError)
                        .frame(minWidth: 100, maxWidth: UIScreen.screenWidth - 32,alignment: .leading)
                        .font(.captionRegular())
                        .foregroundColor(.red)
                    Spacer()
                }
            }
        }
        
    }
}

#Preview {
    PrimaryTextField(inputType: .password, isSecured: .constant(true), inputText: .constant(S.empty), validError: .constant(S.empty), onPressed: {}, onChanged: {_ in }, onSubmit: {})
}
