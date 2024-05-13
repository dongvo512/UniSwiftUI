//
//  ProductItemView.swift
//  UniService
//
//  Created by Admin on 16/01/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductItemView: View {
    
    var productInfo:Product
    var onPressedOrder : (Product) -> ()
    
    private let width_image:CGFloat = 144.0
    private let width_ic_main_dish:CGFloat = 32.0
    
    //@Environment(\.isPresented) var isPresentedLogin:Bool
    
    var body: some View {
       
        VStack(alignment: .leading, content: {
            
            ZStack{
                WebImage(url: URL(string: productInfo.product?.imageURL ?? S.url_empty))
                    .resizable()
                    .placeholder(Image("img_place_holder"))
                    .resizable()
                    .scaledToFill()
                    .frame(width: width_image, height: width_image)
                    .background(.white4)
                    .cornerRadius(12)
                    .clipped()
                
                if let product = productInfo.product, product.isLimit {
                    Image("ic_limit_item")
                        .frame(width: 32, height: 32)
                        .offset(x:-(width_image/2.0) + (width_ic_main_dish / 2.0), y:(width_image/2.0) - (width_ic_main_dish / 2.0))
                }
            }
            
            Text(productInfo.product?.name ?? S.emptyDefault)
                .foregroundColor(.text100)
                .font(.paragraph2Medium())
                .padding(.top, 4)
                .lineLimit(1)
               
            Spacer().frame(height: 4)
            
            Text(productInfo.priceName)
                .foregroundColor(.text100)
                .font(.paragraph2Regular())
                .lineLimit(1)
            
            Button(action: {
                onPressedOrder(productInfo)
            }, label: {
                Text("choose_dish".localized())
                    .font(.captionMedium())
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background((productInfo.isOutOfStock()) ? .gray24 : .blue8)
                    .foregroundColor((productInfo.isOutOfStock()) ? .text60 : .primary100)
                    .disabled(productInfo.isOutOfStock())
                    .cornerRadius(8)
                    .padding(.top, 4)
            })
        }).frame(width:width_image)
    }
}

struct LoadingProductItemView: View {
    
    private let width_image:CGFloat = 144.0
    private let width_ic_main_dish:CGFloat = 32.0
    
    var body: some View {
       
        VStack(alignment: .leading, content: {
            
            ShimmerEffectView()
                .frame(width: width_image, height: width_image)
                .cornerRadius(12)
                .clipped()
            
            ShimmerEffectView()
                .frame(width: 110, height: 20.0)
            
            Spacer().frame(height: 4)
            
        }).frame(width:width_image)
    }
}

#Preview {
    ProductItemView(productInfo: Product(), onPressedOrder: {_ in })
}
