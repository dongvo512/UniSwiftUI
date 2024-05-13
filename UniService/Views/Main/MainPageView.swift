//
//  MainPageView.swift
//  UniService
//
//  Created by Admin on 10/01/2024.
//

import SwiftUI

enum TabType {
    case home
    case service
    case scanQR
    case history
    case account
    
    var title:String{
        switch self {
        case .home:
            S.home
        case .service:
            S.services
        case .scanQR:
            S.emptyDefault
        case .history:
            S.history
        case .account:
            S.account
        }
    }
    
    var index:Int{
        switch self {
        case .home:
            1
        case .service:
            2
        case .scanQR:
            3
        case .history:
            4
        case .account:
            5
        }
    }
}

struct MainPageView: View {
    
    @State private var selectedIndex:Int = TabType.home.index
    @State private var exSelectionIndex:Int = TabType.home.index
    @State private var isPresentedScanQR:Bool = false
    
    @StateObject var userInfoViewModel = UserViewModels()
    
    var body: some View {
        
        NavigationView{
    
            ZStack {
                TabView(selection:$selectedIndex){
                    
                    if userInfoViewModel.userInfo != nil {
                        _userLoggedTabView()
                    }
                    else{
                        _userUnLoggedTabView()
                    }
                }
                .onChange(of: selectedIndex) { newValue in
                   
                    if newValue == TabType.scanQR.index {
                        selectedIndex = exSelectionIndex
                    }
                    else{
                        exSelectionIndex = selectedIndex
                    }
                }
                .tint(.primary100)
                
                // ScanQRCodeButton
                GeometryReader{ geometry in
                    Image("ic_scan_qr")
                        .resizable()
                        .frame(width: 64, height: 64)
                        .offset(x: geometry.size.width / 2 - 32, y: geometry.size.height - 76)
                        .onTapGesture {
    
                            PermissionService.checkPermissionCamera(result: { type in
                                if type == .authorized {
                                    isPresentedScanQR = true
                                   // print("Selected btn ScanQR")
                                }
                            })
                        }
                }
            }
            .fullScreenCover(isPresented: $isPresentedScanQR, content: {

                ScanQRPageView {
                    isPresentedScanQR = false
                } onScanned: { result in
                    isPresentedScanQR = false
                    print("my scannedCode: \(result)")
                }
            })
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - SubsView
    @ViewBuilder private func _userLoggedTabView() -> some View{
        
        // HomePage
        HomePageView().tabItem {
            
            Label(
                title: {
                    Text(S.home)
                },
                icon: {Image("ic_home").renderingMode(.template)
                        
                }
            )
        }
        .environmentObject(userInfoViewModel)
        .tag(TabType.home.index)
        
        // Services Page
        ServicesPageView().tabItem {
            Label(
                title: {
                    Text(S.services)
                },
                icon: {
                    Image("ic_service").renderingMode(.template)
                }
            )
        }
        .tag(TabType.service.index)
        
        // ScanQR Page
        ScanQRPageView().tabItem {
        }
        .tag(TabType.scanQR.index)
        
        // History Page
        HistoryPageView().tabItem {
            Label(
                title: { Text(S.history) },
                icon: { Image("ic_history").renderingMode(.template) }
            )
        }
        .tag(TabType.history.index)
        
        // Account Page
        AccountPageView().tabItem {
            Label(
                title: { Text(S.account) },
                icon: { Image("ic_account").renderingMode(.template) }
            )
        }
        .environmentObject(userInfoViewModel)
        .tag(TabType.account.index)
    }
    
    @ViewBuilder private func _userUnLoggedTabView() -> some View{
       
        // HomePage
        HomePageView().tabItem {
            
            Label(
                title: {
                    Text(S.home)
                },
                icon: {Image("ic_home").renderingMode(.template)
                        
                }
            )
        }
        .environmentObject(userInfoViewModel)
        .tag(TabType.home.index)
        
        // ScanQR Page
        ScanQRPageView().tabItem {
            Text("")
        }
        .tag(TabType.scanQR.index)
        
        // Account Page
        AccountPageView().tabItem {
            Label(
                title: { Text(S.account) },
                icon: { Image("ic_account").renderingMode(.template) }
            )
        }
        .environmentObject(userInfoViewModel)
        .tag(TabType.account.index)
    }
}

#Preview {
    MainPageView()
}
