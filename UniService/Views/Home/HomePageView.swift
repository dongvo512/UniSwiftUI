//
//  HomePageView.swift
//  UniService
//
//  Created by Admin on 10/01/2024.
//

import SwiftUI
import ACarousel
import AnimatedPageControl

struct HomePageView: View {
    @EnvironmentObject private var userInfoViewModel:UserViewModels
    @StateObject private var _productViewModel = ProductViewModels()
    @StateObject private var _promotionViewModel = PromotionViewModel()
   // @StateObject var controlPageModel = AnimatedPageControlViewModel()
   
    @State private var _isPushBranchsPageView = false
    @State private var _isPushOrderedPageView = false
    @State private var _selectedMenuType = TabMenuType.all
    @State private var _selection: Int = 0
    @State private var _isPresentedLogin = false
    @State private var _isPresentedSelectProduct = false
    
   // @State private var _productSelected:Product? = nil
   // @State var numOfProduct:Int = 1
//    @State private var _orderedProduct:Product? = nil
//    @State private var _orderedQuantity:Int? = nil
    
    let menus:Array<TabMenuItem> = [
        TabMenuItem(type: .all),
        TabMenuItem(type: .main),
        TabMenuItem(type: .drink),
        TabMenuItem(type: .specicalfood),
        TabMenuItem(type: .promotion),
        TabMenuItem(type: .neccessary)
    ]
    
    let height_list_menu:CGFloat = 58.0
    let spaceBanner:CGFloat = 12.0
    let widthBanner:CGFloat = UIScreen.screenWidth - 44.0
    var heightBanner:CGFloat {
        return self.widthBanner * 86.0 / 343.0
    }
    
    var body: some View {
        
        ZStack{
            
            VStack(spacing: 0){

                WellcomeView().environmentObject(userInfoViewModel)
                    .onTapGesture {
                        _isPushBranchsPageView = true
                    }
                
                ScrollViewReader { value in
                    ScrollView(.horizontal, showsIndicators:false){
                        
                        // Tab Menus
                        LazyHStack(spacing:8){
                            Spacer(minLength: 8)
                            ForEach (menus){
                                itemMenu in
                                
                                TabMenuItemView(menuItem: itemMenu, selectedMenuType: _selectedMenuType).onTapGesture {
                                    
                                    _selectedMenuType = itemMenu.type
                                }
                                .id(itemMenu.id)
                            }
                            
                            Spacer(minLength: 8)
                        }
                        
                    }
                    .frame(width: UIScreen.screenWidth, height:height_list_menu)
                }
                
                Spacer().frame(height: 16.0)
                
                _uiWithType(tabType: _selectedMenuType)
            }
            
            _navigationLink()
        }
        .onAppear(){
            
            _productViewModel.quantity = 1
            _productViewModel.selectedProduct = nil
            _productViewModel.orderedProduct = nil
        }
        .sheet(isPresented: $_isPresentedSelectProduct, onDismiss: {
            _productViewModel.selectedProduct = nil
            _isPresentedSelectProduct = false
        }, content: {
            if #available(iOS 16.4, *) {
                ZStack {
                    Color.clear
                    SelectProductView(isPresented: $_isPresentedSelectProduct,onPressedAdd: { product,quantity in
                       
                        _productViewModel.orderedProduct = product
                        _productViewModel.quantity = quantity
                        _isPushOrderedPageView = true
                    })
                    .environmentObject(_productViewModel)
                    .presentationBackground(.clear)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.hidden)
                }
                .padding(.horizontal, 8.0)
               
            } else {
                ZStack {
                    Color.clear
                    SelectProductView(isPresented: $_isPresentedSelectProduct,onPressedAdd: {product,quantity in
                        
                        _productViewModel.orderedProduct = product
                        _productViewModel.quantity = quantity
                        _isPushOrderedPageView = true
                    })
                    .environmentObject(_productViewModel)
                    
                }
                .padding(.horizontal, 8.0)
            }
        })
        .sheet(isPresented: $_isPresentedLogin, onDismiss: {
            _isPresentedLogin = false
        }, content: {
            LoginPageView(isPresented: $_isPresentedLogin) {
                Task{
                    await _productViewModel.fetchAllMenu(isRefreshing: true)
                }
                
                userInfoViewModel.fetchUserInfo()
            }
        })
        .bgAppModifier()
    }
    
    // MARK: - SubsView
    
    @ViewBuilder private func _navigationLink() -> some View {
        
        NavigationLink(destination:BranchsPageView(isBack: true),isActive: $_isPushBranchsPageView){
            EmptyView()
        }
        .hidden()
        
        NavigationLink(destination:OrderedProductView(isShouldPopToRootView: $_isPushOrderedPageView).environmentObject(_productViewModel),isActive: $_isPushOrderedPageView){
            EmptyView()
        }
        .hidden()
        
    }
    
    @ViewBuilder private func _uiWithType(tabType:TabMenuType) -> some View {
        
        switch tabType {
        case .all:
            ScrollView(.vertical, showsIndicators:true){
                
                // Today
                VStack{
                    
                    HeaderMenuView(menuType: .today)
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                    
                    if case .onLoading = _productViewModel.stateMenuToday {
                       
                       _loadingProductViews()
                    }
                    else{
                        _contentProductView(products: _productViewModel.menuTodays, onPressed: { product in
                            
                            if !AuthService.shared.isLogged() {
                                
                                _isPresentedLogin.toggle()
                            }
                            else{
                                
                                _productViewModel.selectedProduct = product
                                _isPresentedSelectProduct.toggle()
                            }
                        })
                    }
                }
                
                // Drinks
                VStack{
                    
                    HeaderMenuView(menuType: .drink)
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                    
                    if case .onLoading = _productViewModel.stateMenuDrinks {
                       
                        _loadingProductViews()
                    }
                    else{
                        _contentProductView(products: _productViewModel.menuDrinks, onPressed: {product in 
                           
                            print("onPressed Product")
                            if !AuthService.shared.isLogged() {
                                print("Account UnLogged")
                                _isPresentedLogin.toggle()
                            }
                            else{
                                print("Account Logged")
                                _productViewModel.selectedProduct = product
                                _isPresentedSelectProduct.toggle()
                            }
                        })
                    }
                }
                
                // Foodcourt
                VStack{
                    
                    HeaderMenuView(menuType: .foodcourt)
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                    
                    if case .onLoading = _productViewModel.stateMenuFoodCourt {
                       
                       _loadingProductViews()
                    }
                    else{
                        _contentProductView(products: _productViewModel.menuFoodCourt, onPressed: { product in
                            if !AuthService.shared.isLogged() {
                                _isPresentedLogin.toggle()
                            }
                            else{
                                _productViewModel.selectedProduct = product
                                _isPresentedSelectProduct.toggle()
                            }
                        })
                    }
                }
                
                // SpecicalFood
                VStack{
                    
                    HeaderMenuView(menuType: .specicalfood)
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                    
                    if case .onLoading = _productViewModel.stateMenuSpecicalFood {
                       
                       _loadingProductViews()
                    }
                    else{
                        _contentProductView(products: _productViewModel.menuSpecicalFood, onPressed: { product in
                            if !AuthService.shared.isLogged() {
                                _isPresentedLogin.toggle()
                            }
                            else{
                                _productViewModel.selectedProduct = product
                                _isPresentedSelectProduct.toggle()
                            }
                        })
                    }
                   
                }
                
                // Neccessary
                VStack{
                    
                    HeaderMenuView(menuType: .neccessary)
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                    
                    if case .onLoading = _productViewModel.stateMenuNeccessary {
                       
                       _loadingProductViews()
                    }
                    else{
                        _contentProductView(products: _productViewModel.menuNeccessary, onPressed: { product in
                            if !AuthService.shared.isLogged() {
                                _isPresentedLogin.toggle()
                            }
                            else{
                                _productViewModel.selectedProduct = product
                                _isPresentedSelectProduct.toggle()
                            }
                        })
                    }
                }
                
                // Bottom Space
                Spacer().frame(height: 40)
            }
            .refreshable {
                await _productViewModel.fetchAllMenu(isRefreshing: true)
            }
        case .main:
            if _productViewModel.menuTodays.count > 0 {
                List{
                    ForEach(_productViewModel.menuTodays){
                        product in
                        _contentProductThumView(product: product) {product in 
                            if !AuthService.shared.isLogged() {
                                _isPresentedLogin.toggle()
                            }
                            else{
                               // _productSelected = product
                                _isPresentedSelectProduct.toggle()
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    await _productViewModel.fetchMenuToday(isRefreshing: true)
                }
            }
            else{
                _emptyProdcutView()
            }
            
        case .drink:
            if _productViewModel.menuDrinks.count > 0 {
                List{
                    ForEach(_productViewModel.menuDrinks){
                        product in
                        _contentProductThumView(product: product) { product in
                            if !AuthService.shared.isLogged() {
                                _isPresentedLogin.toggle()
                            }
                            else{
                                _productViewModel.selectedProduct = product
                                _isPresentedSelectProduct.toggle()
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    await _productViewModel.fetchMenuDrinks(isRefreshing: true)
                }
            }
            else{
                _emptyProdcutView()
            }
            
        case .foodcourt:
            if _productViewModel.menuFoodCourt.count > 0{
                List{
                    ForEach(_productViewModel.menuFoodCourt){
                        product in
                        _contentProductThumView(product: product) { product in
                            if !AuthService.shared.isLogged() {
                                _isPresentedLogin.toggle()
                            }
                            else{
                                _productViewModel.selectedProduct = product
                                _isPresentedSelectProduct.toggle()
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    await _productViewModel.fetchMenuFoodCourt(isRefreshing: true)
                }
            }
            else{
                _emptyProdcutView()
            }
        case .specicalfood:
            if _productViewModel.menuFoodCourt.count > 0{
                List{
                    ForEach(_productViewModel.menuSpecicalFood){
                        product in
                        _contentProductThumView(product: product) {product in 
                            if !AuthService.shared.isLogged() {
                                _isPresentedLogin.toggle()
                            }
                            else{
                                _productViewModel.selectedProduct = product
                                _isPresentedSelectProduct.toggle()
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    await _productViewModel.fetchMenuSpecicalFood(isRefreshing: true)
                }
            }
            else{
                _emptyProdcutView()
            }
        case .promotion:
            if _promotionViewModel.promotions.count > 0 {
                List{
                    ForEach(_promotionViewModel.promotions){
                        promotion in
                        PromotionItemThumView(promotion: promotion)
                            .onTapGesture {
                                if let strURL = promotion.redirectURL, let url = URL(string: strURL) {
                                    UIApplication.shared.open(url)
                                }
                            }
                            .background(.bgPrimary)
                            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 12, trailing: 16))
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    await _promotionViewModel.fetchPromotions()
                }
            }
            else{
                _emptyProdcutView()
            }
        case .neccessary:
            if _productViewModel.menuNeccessary.count > 0{
                List{
                    ForEach(_productViewModel.menuNeccessary){
                        product in
                        _contentProductThumView(product: product) { product in
                            if !AuthService.shared.isLogged() {
                                _isPresentedLogin.toggle()
                            }
                            else{
                                _productViewModel.selectedProduct = product
                                _isPresentedSelectProduct.toggle()
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    await _productViewModel.fetchMenuNeccessary(isRefreshing: true)
                }
            }
            else{
                _emptyProdcutView()
            }
        }
    }

    @ViewBuilder private func _loadingProductViews() -> some View{
      
        ScrollView(.horizontal, showsIndicators: false) {
            HStack (spacing: 16.0) {
                ForEach((1..._productViewModel.numOfDummys).reversed(), id: \.self) {_ in
                    LoadingProductItemView()
                }
            }
            .padding(.horizontal, 16.0)
        }
        
    }
    
    @ViewBuilder private func _contentProductThumView(product:Product, onPressed: @escaping (_ product:Product) -> ()) -> some View{
        
        ProductItemThumView(productInfo: product, onPressedOrder: { product in
            
            
        })
        .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
        .listRowSeparator(.hidden)
    }
    
    @ViewBuilder private func _contentProductView(products:Array<Product>, onPressed: @escaping (_ product:Product) -> ()) -> some View{
        
        if(products.count > 0){
           ScrollView(.horizontal,showsIndicators:false){
                
               HStack(spacing: 12.0){
                  
                   ForEach (products){
                        product in
                        
                        ProductItemView(productInfo: product, onPressedOrder: onPressed)
                        
                    }
                }
                .padding(.horizontal, 16.0)
            }
        }
        else{
            PrimaryEmptyView()
        }
    }
    
    @ViewBuilder private func _emptyProdcutView() -> some View{
        ScrollView(.vertical, showsIndicators:true){
            Spacer(minLength: 16)
            PrimaryEmptyView(imgStr: "img_banner_empty")
            Spacer(minLength: 16)
        }
        .refreshable {
            
            
            switch _selectedMenuType {
            case .all:
                await _productViewModel.fetchAllMenu(isRefreshing: true)
            case .main:
                await _productViewModel.fetchMenuToday(isRefreshing: true)
            case .drink:
                await _productViewModel.fetchMenuDrinks(isRefreshing: true)
            case .foodcourt:
                await _productViewModel.fetchMenuFoodCourt(isRefreshing: true)
            case .specicalfood:
                await _productViewModel.fetchMenuSpecicalFood(isRefreshing: true)
            case .promotion:
                await _promotionViewModel.fetchPromotions()
            case .neccessary:
                await _productViewModel.fetchMenuNeccessary(isRefreshing: true)
            }
        }
    }
}


#Preview {
    HomePageView()
}


/*
 //                    if (promotionModel.promotions.count > 0){
 //                        // Banner
 //                        VStack{
 //                            ACarousel(promotionModel.promotions, index:$_selection, spacing: 12, sidesScaling: 1.0, autoScroll: .active(3)){
 //                                promotion in
 //
 //                                AsyncImage(url: URL(string: promotion.imageURL ?? S.url_empty)) { image in  // <-- here
 //                                         image.resizable()
 //                                     } placeholder: {
 //                                         Image("img_banner_holder")
 //                                             .resizable()
 //                                             .scaledToFill()
 //                                             .cornerRadius(12)
 //                                     }
 //                                     .scaledToFill()
 //                                     .frame(width: widthBanner, height: heightBanner)
 //                                     .background(.white4)
 //                                     .cornerRadius(12)
 //                                     .clipped()
 //
 //                            }
 //                            .frame(width: UIScreen.screenWidth, height: heightBanner)
 //                            .offset(x:-6)
 //                            .padding(.top, 16)
 //                            .padding(.bottom, 12)
 //
 //                            // Control Page
 //                            AnimatedPageControlView(viewModel: controlPageModel,
 //                                                                selectedIndex: _selection,
 //                                                    pageCount: promotionModel.promotions.count,
 //                                                                maxDisplayedDots: 7,
 //                                                                dotSpacing: 12,
 //                                                                dotSize: 8,
 //                                                    selectedColor: .primary100,
 //                                                    defaultColor: .gray24)
 //                        }
 //
 //                    }
 */
