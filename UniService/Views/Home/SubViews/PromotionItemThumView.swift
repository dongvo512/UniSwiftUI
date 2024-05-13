//
//  PromotionItemThumView.swift
//  UniService
//
//  Created by Admin on 30/01/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct PromotionItemThumView: View {
    
    var promotion:Promotion
    
    private let width_image:CGFloat = UIScreen.screenWidth - 32.0
    private var height_image:CGFloat {
        return width_image * 86.0 / 343.0
    }
    
    var body: some View {
        
        WebImage(url: URL(string: promotion.imageURL ?? S.url_empty))
            .resizable()
            .placeholder(Image("img_banner_holder"))
            .scaledToFill()
            .frame(width: width_image, height: height_image)
            .background(.white4)
            .cornerRadius(12)
            .clipped()
        
//        WebImage(url: URL(string: promotion.imageURL ?? S.url_empty)) { image in  // <-- here
//                 image.resizable()
//             } placeholder: {
//                 Image("img_banner_holder")
//                     .resizable()
//                     .scaledToFill()
//                     .cornerRadius(12)
//             }
//             .scaledToFill()
//             .frame(width: width_image, height: height_image)
//             .background(.white4)
//             .cornerRadius(12)
//             .clipped()
    }
}

#Preview {
    PromotionItemThumView(promotion: Promotion(title: "Banner Title"))
}
