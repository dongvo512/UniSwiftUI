//
//  SelectProductView.swift
//  UniService
//
//  Created by Admin on 30/01/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct SelectProductView: View {
    
    @EnvironmentObject var productViewModel:ProductViewModels
    
    @State private var quantityCurr:Int = 1
    var isEditing:Bool = false
    
//    @Binding var product:Product?
//    @Binding var quantityCurr:Int
    @Binding var isPresented:Bool
    var onPressedAdd : (_ product:Product,_ quantity:Int) -> ()
    
    private let width_image:CGFloat = 84.0
    private let height_image:CGFloat = 84.0
    
    var body: some View {
        
        VStack {
           
            VStack (spacing:8.0){
                
                Spacer().frame(height: 8.0)
                
                DragHeaderView()
                
                HStack {
                    Text("options".localized())
                        .font(.paragraph2Medium())
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                
                if let product = (isEditing) ? productViewModel.orderedProduct : productViewModel.selectedProduct {
                    
                    _productInfoView(product: product)
                    
                }
               
                Spacer().frame(minHeight: 16.0)
                
                PrimaryButton(title: ((isEditing) ? "confirm".localized() : "add_in_cart".localized()), state: productViewModel.stateAddProduct) {
                  
                    if let product = (isEditing) ? productViewModel.orderedProduct : productViewModel.selectedProduct {
                        productViewModel.addOrderedCart(product: product, completed: {
                            isSuccess in
                            
                            if isSuccess {
                                if isEditing, let product = productViewModel.orderedProduct{
                                    self.onPressedAdd(product, quantityCurr)
                                }
                                else if !isEditing, let product = productViewModel.selectedProduct{
                                    self.onPressedAdd(product, quantityCurr)
                                }
                                
                                isPresented = false
                            }
                        })
                    }
                   
                    
//                    if isEditing, let product = productViewModel.orderedProduct{
//                        self.onPressedAdd(product, quantityCurr)
//                    }
//                    else if !isEditing, let product = productViewModel.selectedProduct{
//                        self.onPressedAdd(product, quantityCurr)
//                    }
//                    
//                    isPresented = false
                }
            }
            .padding(16.0)
            .background(.white100)
            .cornerRadius(12.0)
            
            Button (action:{
                isPresented = false
            }){
                HStack {
                    
                    Spacer()
                    
                    Text("cancel".localized())
                        .font(.paragraph2Regular())
                        .foregroundColor(.text100)
                    
                    Spacer()
                }
                .frame( height: 52.0)
                .background(RoundedRectangle(cornerRadius: 12.0).fill(.white100))
            }
        }
        .onAppear(){
            
            quantityCurr = productViewModel.quantity
        }
    }
    
    @ViewBuilder private func _productInfoView(product:Product) -> some View {
       
        HStack(spacing: 8.0){
            
            WebImage(url: URL(string: product.product?.imageURL ?? S.url_empty))
                .resizable()
                .placeholder(Image("img_place_holder"))
                .scaledToFill()
                .frame(width: width_image, height: height_image)
                .background(.white4)
                .cornerRadius(12)
                .clipped()
            
            VStack(alignment: .leading, spacing: 4, content: {
                Text(product.product?.name ?? S.emptyDefault)
                    .foregroundColor(.text100)
                    .font(.paragraph1Medium())
                    .lineLimit(2)
                
                if let decription = product.product?.description {
                    Text(decription)
                        .foregroundColor(.text80)
                        .font(.paragraph2Regular())
                        .lineLimit(2)
                }
                
                Text((product.getPrice().formatnumber()) + " đ")
                    .foregroundColor(.text100)
                    .font(.paragraph1Regular())
                    .lineLimit(2)
                
                Spacer().frame(height: 8.0)
                
                _countProductView(product: product)
            })
            
            Spacer()
        }
    }
    
    @ViewBuilder private func _countProductView(product:Product) -> some View {
        
        HStack(spacing:8.0) {
            
            Button(action: {
                
                quantityCurr -= 1
        
            }, label: {
                
                Image((quantityCurr <= 1) ? "btn_minute_disable" : "btn_count_minus")
                    .resizable()
                    .frame(width: 24, height: 24)
                    
            })
            .disabled((quantityCurr <= 1) ? true : false)
            
            Text(String(quantityCurr))
                .foregroundColor(.text100)
                .font(.paragraph2Regular())
                .lineLimit(1)
            
            Button(action: {
                
                let countTemp = quantityCurr + 1
                
                if countTemp > product.quantity {
                    AppToast.showToast(toastType: .custom(title: "", image: UIImage(named:"ic_warning")!), mess: "maximum_quantity".localized() + String(product.quantity), from: .bottom)
                }
                else{
                    quantityCurr = countTemp
                }
                
            }, label: {
                
                Image("btn_plus")
                    .resizable()
                    .frame(width: 24, height: 24)
                    
            })
            
            Text("remaining".localized() + "\(String(product.quantity))")
                .foregroundColor(.text100)
                .font(.paragraph2Regular())
                .lineLimit(1)
        }
    }
}

//#Preview {
//    SelectProductView(productInfo: <#Product#>, onPressedAdd: <#() -> ()#>)
//}
