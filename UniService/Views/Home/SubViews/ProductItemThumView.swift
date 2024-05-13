//
//  ProductItemThumView.swift
//  UniService
//
//  Created by Admin on 30/01/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductItemThumView: View {
    
    var productInfo:Product
    var onPressedOrder : (Product) -> ()
    
    private let width_image:CGFloat = 84.0
    private let height_image:CGFloat = 84.0
    
    var body: some View {
       
        VStack{
            HStack{
                
                WebImage(url: URL(string: productInfo.product?.imageURL ?? S.url_empty))
                    .resizable()
                    .placeholder(Image("img_place_holder"))
                    .scaledToFill()
                    .frame(width: width_image, height: height_image)
                    .background(.white4)
                    .cornerRadius(12)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 4, content: {
                    Text(productInfo.product?.name ?? S.emptyDefault)
                        .foregroundColor(.text100)
                        .font(.paragraph1Medium())
                        .lineLimit(2)
                    
                    if let decription = productInfo.product?.description {
                        Text(decription)
                            .foregroundColor(.text80)
                            .font(.paragraph2Regular())
                            .lineLimit(2)
                    }
                    
                    Text((productInfo.price?.formatnumber() ?? "0") + " đ")
                        .foregroundColor(.text100)
                        .font(.paragraph1Regular())
                        .lineLimit(2)
                })
                
                Spacer()
                
                VStack {
                    Spacer()
                    Button(action: {
                        onPressedOrder(productInfo)
                    }, label: {
                        Image("btn_plus")
                            .resizable()
                            .frame(width: 24, height: 24)
                            
                    })
                }
            }
            
            AppDivider()
        }
        

    }
}

#Preview {
    ProductItemThumView(productInfo: Product(), onPressedOrder: {_ in})
}
