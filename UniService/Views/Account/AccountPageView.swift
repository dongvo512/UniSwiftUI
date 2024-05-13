//
//  AccountPageView.swift
//  UniService
//
//  Created by Admin on 10/01/2024.
//

import SwiftUI

struct AccountPageView: View {
    
    @EnvironmentObject var userInfoViewModel:UserViewModels
    @State private var _isScureMoney:Bool = true
    
    let user_settings:Array<ItemSetting> = [
        ItemSetting(ic_image: "ic_profile", title: "account_information".localized()),
        ItemSetting(ic_image: "ic_setting", title: "setting".localized()),
        ItemSetting(ic_image: "ic_report", title: "feedback".localized()),
        ItemSetting(ic_image: "ic_contact", title: "contact".localized()),
        ItemSetting(ic_image: "ic_lock", title: "privacy_policy".localized()),
        ItemSetting(ic_image: "ic_term", title: "terms_of_services".localized()),
        ItemSetting(ic_image: "ic_logout", title: "logout".localized()),
    ]
    
    let user_none_settings:Array<ItemSetting> = [
        ItemSetting(ic_image: "ic_setting", title: "setting".localized()),
        ItemSetting(ic_image: "ic_contact", title: "contact".localized()),
        ItemSetting(ic_image: "ic_lock", title: "privacy_policy".localized()),
        ItemSetting(ic_image: "ic_term", title: "terms_of_services".localized()),
    ]
    
    @State private var _isPresentLogin:Bool = false
    
    var body: some View {
        
        ScrollView{
            VStack(spacing: 12.0){
                Spacer().frame(height: 8.0)
                
                _userLoginView(user: userInfoViewModel.userInfo)
               
                Spacer().frame(height: 16.0)
                
                _depositInfoView(user: userInfoViewModel.userInfo)
                
                Spacer().frame(height: 12.0)
                
                ForEach((userInfoViewModel.userInfo != nil) ? user_settings : user_none_settings){
                    item in
                    
                    _itemSettingView(itemSetting: item)
                }
            }
        }
        .bgAppModifier()
        .sheet(isPresented: $_isPresentLogin) {
            _isPresentLogin = false

        } content: {
            LoginPageView(isPresented: $_isPresentLogin) {
                userInfoViewModel.fetchUserInfo()
            }
        }

    }
    
    @ViewBuilder private func _depositInfoView(user:UserInfo?) -> some View{
     
        if let userInfo = user {
           
            VStack {
                
                Spacer().frame(height: 24.0)
                
                Image("img_temp_cart")
                    .resizable()
                    .frame(width: 160.0, height: 160.0)
                
                Spacer().frame(height: 12.0)
                
                VStack(spacing:4.0) {
                    
                    Spacer().frame(height: 12.0)
                    
                    Text("current_balance".localized())
                        .font(.paragraph2Regular())
                        .foregroundColor(.text80)
                    
                    HStack (){
                        Text((_isScureMoney) ? String(userInfo.point).security() : Int(userInfo.point).formatnumber())
                            .font(.bigTitleBold())
                            .foregroundColor(.text100)
                        Text("đ".localized())
                            .font(.bigTitleBold())
                            .foregroundColor(.text100)
                        Image("ic_eye")
                            .resizable()
                            .frame(width: 24.0, height: 24.0)
                    }
                    .onTapGesture {
                        _isScureMoney.toggle()
                    }
                    
                    Spacer().frame(height: 4.0)
                    
                    PrimaryButton(title: "deposit".localized(), imageStr:"ic_deposit", tintColorIcon:Color.white, onPressed: {
                        
                    })
                    .padding(.horizontal, 24.0)
                    
                    Spacer().frame(height: 12.0)
                }
                .clipped()
                .background(Color.white100)
                .cornerRadius(12.0)
                .padding(.horizontal, 40.0)
            }
            .background {
                Image("img_background_qr")
                    .resizable()
                    .frame(width: UIScreen.screenWidth - 32.0)
                    .cornerRadius(16.0)
                    .clipped()
                    .scaledToFill()
            }

        }
    }
    
    @ViewBuilder private func _userLoginView(user:UserInfo?) -> some View{
       
        if let userInfo = user {
            VStack {
                ZStack {
                    
                    AsyncImage(url: URL(string: userInfoViewModel.userInfo?.avatar ?? S.url_empty)) { image in  // <-- here
                             image.resizable()
                         } placeholder: {
                             Image("img_avatar")
                                 .resizable()
                                 .clipped()
                                 .frame(width: 80, height: 80)
                                 .scaledToFill()
                                 .cornerRadius(40)
                         }
                         .scaledToFill()
                         .frame(width: 80, height: 80)
                         .background(.white4)
                         .cornerRadius(40)
                         .clipped()
                    
                    Image("ic_take_avatar")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .scaledToFill()
                        .offset(x:25, y: 30)
                }
               
                
                Text(userInfo.fullName ?? S.emptyDefault)
                    .font(.heading6Bold())
               
                if let role = userInfo.role {
                    Text(role)
                        .font(.paragraph2Regular())
                }
            }
        }
        else{
            VStack {
                Image("img_login_none")
                Spacer().frame(height: 24.0)
                
                HStack (spacing: 16){
                    
                    Spacer()
                    
                    PrimaryButton(title: "login".localized(), heightButton: 36.0, isEnable: true, onPressed: {
                        
                        _isPresentLogin = true
                        
                    })
                    
                    SecondButtonOutline(title: "register".localized(), onPressed: {
                        
                    }, heightButton: 36.0, isEnable: true)
                    
                    Spacer()
                }
            }
        }
    }
    
    @ViewBuilder private func _itemSettingView(itemSetting:ItemSetting) -> some View{
       
        VStack{

            Button(action: {
                if itemSetting.title == "logout".localized() {
                    
                    AppAlert.showAlertOKCancel(title: "logout_confirmation".localized(), mess: S.empty) {
                        userInfoViewModel.logout()
                    }
                }
            }) {
                
                switch itemSetting.title {
                case "account_information".localized():
                    _itemSettingContent(itemSetting: itemSetting)
                case "setting".localized():
                    _itemSettingContent(itemSetting: itemSetting)
                case "feedback".localized():
                    _itemSettingContent(itemSetting: itemSetting)
                case "contact".localized():
                    _itemSettingContent(itemSetting: itemSetting)
                case "privacy_policy".localized():
                    _itemSettingContent(itemSetting: itemSetting)
                case "terms_of_services".localized():
                    _itemSettingContent(itemSetting: itemSetting)
                default:
                    _itemSettingContent(state: userInfoViewModel.stateUserLogout, itemSetting: itemSetting)
                }
            }
            .frame(height: 64.0)
            
            Divider()
                .padding(.leading, 24.0)
        }
        .padding(.leading, 16.0)
    }
    
    @ViewBuilder private func _itemSettingContent(state:BaseState? = nil, itemSetting:ItemSetting) -> some View {
       
        if case .onLoading = state {
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .text100))
                .frame(minWidth: 0, maxWidth: .infinity)
        }
        else{
            
            HStack(spacing:16.0){
                Image(itemSetting.ic_image)
                
                Text(itemSetting.title)
                    .font(.paragraph2Regular())
                    .foregroundColor((itemSetting.title == "logout".localized()) ? .red100 : .text100 )
                
                Spacer()
                
                Image("ic_arrow_right")
                    .padding(.trailing, 16)
            }
        }
    }
}

#Preview {
    AccountPageView()
}
