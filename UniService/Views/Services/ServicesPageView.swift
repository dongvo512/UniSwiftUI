//
//  ServicesPageView.swift
//  UniService
//
//  Created by Admin on 10/01/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ServicesPageView: View {
    
    @StateObject var servicesViewModel = ServiceViewModels()
    
    let colums = [GridItem(.flexible(minimum: 100), spacing: 12.0),
                  GridItem(.flexible(minimum: 100), spacing: 12.0
                          )]
    
    let width_img = (UIScreen.screenWidth - 32.0 - 12.0) / 2
    var height_img: CGFloat {
        return width_img * 122.0 / 166.0
    }
    
    var body: some View {
        
        VStack {
            
            PrimaryHeaderNavigation(isBack: .constant(false), title: "service".localized())
            
            ScrollView {
                
                LazyVGrid(columns: colums, content: {
                    
                    if case .onLoading = servicesViewModel.stateServices {
                        
                        ForEach((0...servicesViewModel.numOfDummys).reversed(), id: \.self) {_ in
                            _loadingView()
                        }
                    }
                    else{
                        ForEach(servicesViewModel.services) { service in
                            _serviceItemView(service: service)
                        }
                    }
                    
                   
                })
                .padding(16.0)
            }
            .refreshable {
                await servicesViewModel.fetchData()
            }
        }
    }
    
    // MARK: - SubsView
    
    @ViewBuilder private func _loadingView() -> some View {
        
        VStack {
            
           ShimmerEffectView()
                .frame(width: width_img, height: height_img)
            
            HStack {
                
                ShimmerEffectView()
                    .frame(width: 80.0, height: 22.0)
                
                Spacer()
                
            }
            .padding(12.0)
        }
        .background(.white100)
        .cornerRadius(12.0)
        .shadow(color: .shadow,radius: 4, x: 2, y: 2)
    }
    
    
    @ViewBuilder private func _serviceItemView(service:Service) -> some View{
        
        VStack {
            
            WebImage(url: URL(string: service.img ?? S.url_empty))
                .resizable()
                .placeholder(Image("img_place_holder"))
                .resizable()
                .cornerRadius(12)
                .scaledToFill()
              .frame(width: width_img, height: height_img)
                .background(.white4)
            
            HStack {
                
                Text(service.name ?? S.emptyDefault)
                    .font(.heading5Medium())
                    .foregroundColor(.text100)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Text("book_tickets".localized())
                        .font(.captionRegular())
                        .padding(8.0)
                        .foregroundColor(.primary100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(.primary100, lineWidth: 1)
                                .frame(height: 22.0)
                        )
                }
            }
            .padding(12.0)
        }
//        .foregroundStyle(.linearGradient(colors: [Color.blue, Color.red], startPoint: .top, endPoint: isLoading ? .bottom : .top))
//        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: false),value: isLoading)
//        .redacted(reason: isLoading ? .placeholder : [])
//       
//        .allowsHitTesting(isLoading)
        .background(.white100)
        .cornerRadius(12.0)
        .shadow(color: .shadow,radius: 4, x: 2, y: 2)
    }
}

#Preview {
    ServicesPageView()
}
