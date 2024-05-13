//
//  BranchItemView.swift
//  UniService
//
//  Created by Admin on 29/01/2024.
//

import SwiftUI

struct BranchItemView: View {
    
    var branch:Branch
    var idSelectedBranch:String? = nil
    
    var body: some View {
       
        VStack {
            HStack{
                VStack(alignment: .leading,spacing: 4, content: {
                    Text(branch.name ?? S.emptyDefault)
                        .font(.paragraph2Regular())
                        .foregroundColor(.text100)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                   
                    Text(branch.description ?? S.empty)
                        .font(.captionRegular())
                        .foregroundColor(.text60)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                })
                
                Spacer()
              
                if idSelectedBranch != nil && idSelectedBranch == branch.id {
                    Image("ic_ratio_selected")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                else{
                    Image("ic_ratio_none")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
            
            AppDivider()
        }
        .frame(minHeight: 58)
    }
}

#Preview {
    BranchItemView(branch:Branch(name: "Chi nhánh 1", description: "268 Lý Thường Kiệt, P.14, Quận 10, Tp.HCM"))
}
