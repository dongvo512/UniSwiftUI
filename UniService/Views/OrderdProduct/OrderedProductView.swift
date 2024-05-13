//
//  OrderdProductView.swift
//  UniService
//
//  Created by Admin on 18/03/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct OrderedProductView: View {
    
    @EnvironmentObject var productViewModel:ProductViewModels
    @Binding var isShouldPopToRootView:Bool
    
    @State private var _isPresentedSelectProduct:Bool = false
    @State private var _isPushOrderBillPage:Bool = false
    
    var body: some View {
        
        VStack {
            
            PrimaryHeaderNavigation(isBack: .constant(true), title: "order".localized())
           
            if let product = productViewModel.orderedProduct {
                
                HStack {
                    
                    Text((product.isLimitedProduct) ? "cart_header_limit".localized() : "unlimit_product".localized())
                        .font(.paragraph2Medium())
                        .foregroundColor(.text100)
                    
                    Spacer()
                }
                .padding(.horizontal, 16.0)
                
                Spacer().frame(height: 16.0)
                
                _orderedProduct(product: product)
                    .padding(.horizontal, 16.0)
                
                Spacer()
                
                TotalView(totalPrice: product.getPrice() * productViewModel.quantity) {
                    
                    _isPushOrderBillPage = true
                }
            }
            
            if let idBill = productViewModel.idBill {
                NavigationLink(destination:OrderBillView(idBill:idBill, isShouldPopToRootView: $isShouldPopToRootView).environmentObject(productViewModel),isActive: $_isPushOrderBillPage){
                    EmptyView()
                }
                .hidden()
            }
        }
        .sheet(isPresented: $_isPresentedSelectProduct, onDismiss: {
            _isPresentedSelectProduct = false
        }, content: {
            
            if #available(iOS 16.4, *) {
                ZStack {
                    Color.clear
                    SelectProductView(isEditing: true, isPresented: $_isPresentedSelectProduct,onPressedAdd: { product,quantity in
                       
                        self.productViewModel.quantity = quantity
                    })
                    .environmentObject(productViewModel)
                    .presentationBackground(.clear)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.hidden)
                }
                .padding(.horizontal, 8.0)
               
            } else {
                ZStack {
                    Color.clear
                    SelectProductView(isEditing: true, isPresented: $_isPresentedSelectProduct,onPressedAdd: {product,quantity in
                        
                        self.productViewModel.quantity = quantity
                    })
                }
                .padding(.horizontal, 8.0)
            }
            
        })
        .navigationBarHidden(true)
        .bgAppModifier()
    }
    
    // MARK: - SubsView
    
    @ViewBuilder private func _orderedProduct(product:Product) -> some View {
      
        HStack(spacing: 12.0){
            
            WebImage(url: URL(string: product.product?.imageURL ?? S.url_empty))
                .resizable()
                .placeholder(Image("img_place_holder"))
                .scaledToFill()
                .frame(width: 64.0, height: 64.0, alignment: .top)
                .background(.white4)
                .cornerRadius(4.0)
                .clipped()
            
            VStack(alignment: .leading, spacing: 4, content: {
                
                HStack {
                    
                    Text(product.product?.name ?? S.emptyDefault)
                        .foregroundColor(.text100)
                        .font(.paragraph1Regular())
                        .lineLimit(2)
                    
                    Spacer()
                    
                    Text("x \(productViewModel.quantity)")
                        .foregroundColor(.text100)
                        .font(.paragraph1Regular())
                }
                
               
                HStack {
                    
                    if let decription = product.product?.description {
                        Text(decription)
                            .foregroundColor(.text80)
                            .font(.paragraph2Regular())
                            .lineLimit(2)
                    }
                    
                    Spacer()
                }
                
                Spacer().frame(height: 12.0)
                
                HStack {
                    
                    Button(action:{
                        
                        _isPresentedSelectProduct = true
                        
                    }){
                        Text("edit".localized())
                            .foregroundColor(.primary100)
                            .font(.paragraph2Regular())
                    }
                    
                    Spacer()
                    
                    Text("\(product.getPrice()) đ")
                        .foregroundColor(.text100)
                        .font(.subTitle2Medium())
                }
            })
        }
    }
}

#Preview {
    OrderedProductView(isShouldPopToRootView:.constant(false))
}
