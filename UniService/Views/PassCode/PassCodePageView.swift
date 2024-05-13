//
//  PassCodePageView.swift
//  UniService
//
//  Created by Admin on 25/01/2024.
//

import SwiftUI


enum PassCodePageType {
    case createPin
    case confirmCreatePin
    
    var title:String {
        switch self {
        case .createPin:
            return "create_pin".localized()
        case .confirmCreatePin:
            return "create_pin".localized()
        }
    }
    
    var subTitle:String {
        switch self {
        case .createPin:
            return "enter_pin".localized()
        case .confirmCreatePin:
            return "reenter_pin_to_confirm".localized()
        }
    }
}

struct PassCodePageView: View {
    
    @EnvironmentObject var authViewModel:AuthenticateViewModel
    
    var pageType:PassCodePageType
    var createdPassCode:String? = nil
    @Binding var isPresented:Bool
    var finishVerifyAccount: (() -> ())? = nil
   
    @State private var _isPushPassCodeConfirmView:Bool = false
    @State private var _passCode:String = S.empty
    @State private var _errorPassCode:String = S.empty
    
    private let _numOfPassCode:Int = 4
    @FocusState private var _isFocused:Bool
  
    var body: some View {
        
            VStack{
                PrimaryHeaderNavigation(isBack: .constant(true), title: pageType.title)
                    
                Spacer().frame(height: 64)
                Text(pageType.subTitle)
                
                Spacer().frame(height: 24)
                
                ZStack{
                    
                    TextField("", text: $_passCode)
                        .onChange(of: _passCode, perform: { value in
                            if value.count > _numOfPassCode {
                              
                                _passCode = value.substring(to: _numOfPassCode)
                            }
                            _handlePassCode(passCode: _passCode, createdPassCode: createdPassCode)
                            
                        })
                        .focused($_isFocused)
                        .frame(width: 80,alignment: .center)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                    
                    LazyHStack{
                        ForEach((1..._numOfPassCode).reversed(), id:\.self){
                            index in
                        
                            if index <= _passCode.count {
                                Circle()
                                    .fill(.primary100)
                                    .frame(width: 20, height: 20)
                                    .padding(.all, 12)
                            }
                            else{
                                Circle()
                                    .stroke(.gray60, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                                    .frame(width: 20, height: 20)
                                    .padding(.all, 12)
                            }
                        }
                    }
                    .background(.white)
                    .rotationEffect(.radians(.pi))
                    .frame(width: 168, height: 44)
                }
                
                if !_errorPassCode.isEmpty {
                    Text(_errorPassCode)
                        .frame(minWidth: 100, maxWidth: UIScreen.screenWidth - 32,alignment: .center)
                        .font(.captionRegular())
                        .foregroundColor(.red)
                }
                Spacer()
                
                NavigationLink(destination: PassCodePageView(pageType: .confirmCreatePin, createdPassCode: _passCode, isPresented: $isPresented, finishVerifyAccount: finishVerifyAccount).environmentObject(authViewModel), isActive: $_isPushPassCodeConfirmView){
                    EmptyView()
                }
            }
            .navigationBarHidden(true)
            .onAppear(){
                _isFocused = true
            }
    }
    
    private func _handlePassCode(passCode:String, createdPassCode:String? = nil){
        
        switch pageType {
        case .createPin:
            if passCode.count == _numOfPassCode {
                _isFocused = false
                _isPushPassCodeConfirmView = true
            }
        case .confirmCreatePin:
            if let createdPCode = createdPassCode, passCode.count == _numOfPassCode{
                
                if createdPCode == passCode {
                    _errorPassCode = S.empty
                    LocaleStorageService.shared.savePINCode(pinCode: passCode)
                    if let accessToken = authViewModel.authenticate?.access_token {
                        LocaleStorageService.shared.saveAccessTokenCurr(access_token: accessToken)
                    }
                    finishVerifyAccount?()
                    isPresented = false
                }
                else{
                    _errorPassCode = "wrong_pin".localized()
                }
            }
            else{
                _errorPassCode = S.empty
            }
            
        }
    }
}

#Preview {
    PassCodePageView(pageType: .createPin, isPresented: .constant(true))
}
