//
//  WellcomeView.swift
//  UniService
//
//  Created by Admin on 12/01/2024.
//

import SwiftUI

struct WellcomeView: View {
    
    @EnvironmentObject var userInfoViewModel:UserViewModels
    
    var body: some View {
        HStack{
            
            AsyncImage(url: URL(string: userInfoViewModel.userInfo?.avatar ?? S.url_empty)) { image in  // <-- here
                     image.resizable()
                 } placeholder: {
                     Image("img_avatar")
                         .resizable()
                         .frame(width: 48, height: 48)
                         .scaledToFill()
                         .cornerRadius(24)
                 }
                 .scaledToFill()
                 .frame(width: 48, height: 48)
                 .background(.white4)
                 .cornerRadius(24)
                 .clipped()
            
            VStack(alignment: .leading, spacing: 8, content: {
                
                if let userInfo = userInfoViewModel.userInfo {
                   
                    Text(userInfo.fullName ?? S.emptyDefault)
                        .font(.paragraph1Medium())
                        .foregroundStyle(.text100)
                }
                else{
                    Text("good_morning".localized())
                        .font(.paragraph2Regular())
                        .foregroundStyle(.text80)
                }
                
                if let branchCurr = LocaleStorageService.shared.getBranchCurr() {
                  
                    ZStack{
                        HStack {
                            Image("ic_branch")
                                .resizable()
                                .frame(width: 20, height: 20)
                               
                            Text(branchCurr.name ?? S.emptyDefault)
                                .font(.captionRegular())
                                .lineLimit(2)
                               
                            Image("ic_dropdown")
                                .resizable()
                                .frame(width: 16, height: 16)
                                
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                    }
                    .border(.gray24, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, cornerRadius:14)
                    
                }
            })
            .padding(.horizontal, 4)
            
            Spacer()
            
            ZStack{
                Image("ic_bills")
                VStack{
                    Circle()
                        .fill(.white100)
                        .frame(width: 14, height: 14)
                        .overlay {
                            Circle()
                                .fill(.red)
                                .frame(width: 12,height: 12)
                                .overlay {
                                    Text("99")
                                        .font(.numBold())
                                        .foregroundStyle(.white100)
                                }
                        }
                        .offset(x: 5, y: -3)
                    Spacer()
                }
            }
            .frame(width: 24, height: 24)
        }.padding()
    }
}

#Preview {
    WellcomeView()
}
