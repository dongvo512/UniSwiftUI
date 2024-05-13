//
//  LoginViewPage.swift
//  UniService
//
//  Created by Admin on 18/01/2024.
//

import SwiftUI
import AlertToast

struct LoginPageView: View {
    
    @ObservedObject var authViewModel = AuthenticateViewModel()
    @Binding var isPresented:Bool
    var finishVerifyAccount: (() -> ())? = nil
    
//    @State private var _email = S.empty
//    @State private var _password = S.empty
    @State private var _email = "dongvo@yopmail.com"
    @State private var _password = "Dongvo512@"
    @State private var _errorEmail = S.empty
    @State private var _errorPassword = S.empty
  //  @State private var _errorToast = S.empty
 //   @State private var _isPresentToast = false
    @State private var _isPushPassCodeCreateView:Bool = false
    @State private var _loginState:BaseState? = nil
    @FocusState private var _focusedField:Field?
    
    @State private var _isOpenEyePassword:Bool = true
    
    var body: some View {
        NavigationView{
            VStack{
                
                Spacer().frame(height: 24)
                
                Image("img_bktphcm")
                    .resizable()
                    .frame(width: 80, height: 80)
                
                Spacer().frame(height: 24)
                
                PrimaryTextField(inputType: .email, isSecured: .constant(false), inputText: $_email, validError: $_errorEmail, focusState: __focusedField, onSubmit: {
                    
                    _ = _isValidLoginView()
                })
                
                Spacer().frame(height: 24)
                
                PrimaryTextField(inputType: .password, isSecured: $_isOpenEyePassword, inputText: $_password, validError: $_errorPassword, focusState: __focusedField, onSubmit: {
                    
                    _ = _isValidLoginView()
                })
                
                Spacer().frame(height: 16)
                
                HStack{
                    Spacer()
                    // Button forget password
                    Button(action: {
                        //isPushPassCodeView = true
                    }, label: {
                        Text("forgot_password".localized())
                            .font(.paragraph2Regular())
                            .foregroundColor(.primary100)
                    })
                }
                
                Spacer()
                
                // Button Login
                PrimaryButton(title: "Login".localized(), isEnable: true, state: _loginState, onPressed: {
                    _focusedField = nil
                    
                    if _isValidLoginView() {
                        authViewModel.login(email: _email, password: _password, 
                                            onLoading: {
                            _loginState = .onLoading
                        }, onSuccess: {
                            auth in
                            _loginState = .onSuccess(auth)
                            _isPushPassCodeCreateView = true
                        }, onError: {
                            e in
                            _loginState = .onError(e)
                            _handleError(e: e)
                        })
                    }
                    
                })
                
                NavigationLink(destination: PassCodePageView(pageType: .createPin, isPresented: $isPresented, finishVerifyAccount:finishVerifyAccount).environmentObject(authViewModel), isActive: $_isPushPassCodeCreateView){
                    EmptyView()
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                dismissKeyboard()
            }
            .background(.white100)
            .padding(.all,16)
            .onAppear(){
                _focusedField = .email
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarHidden(true)
    }
    
    private func _handleError(e:AppException?){
        
        if let validates = e?.errorValidate, validates.count > 0 {
            for validate in validates {
                if validate.field == AuthenticateBody.email.key {
                    _errorEmail = validate.message ?? S.empty
                    return
                }
                else if validate.field == AuthenticateBody.password.key {
                    _errorPassword = validate.message ?? S.empty
                    return
                }
            }
        }
    }
    
    private func _isValidLoginView() -> Bool{
        
        _errorEmail = _email.getValidEmail()
        _errorPassword = _password.getValidPassword()
        
        return (_errorEmail.isEmpty && _errorPassword.isEmpty)
    }
}

#Preview {
    LoginPageView(isPresented: .constant(true))
}
