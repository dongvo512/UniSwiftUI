//
//  ScanQRPageView.swift
//  UniService
//
//  Created by Admin on 10/01/2024.
//

import SwiftUI
import CodeScanner

struct ScanQRPageView: View {
    
    var onClossed : (() -> Void)? = nil
    var onScanned : ((String) -> Void)? = nil
    
    @Environment(\.dismiss) var dismiss
    // 313/375
    private let widthCamera:CGFloat = UIScreen.screenWidth * 313.0 / 375.0
    
    var body: some View {
       
        GeometryReader{
            geoProxy in
            let topInset = geoProxy.safeAreaInsets.top
           
            ZStack {
                CodeScannerView(codeTypes: [.qr, .code128]) { response in
                    if case let .success(result) = response {
                        let scannedCode = result.string
                        onScanned?(scannedCode)
                        //print("my scannedCode: \(String(describing: result.string))")
                        
                    }
                }
                
                VStack(spacing:0.0) {
                    
                    Color.clear
                        .frame(height: abs(topInset))

                    _header {
                        onClossed?()
                    }
                    
                    Color.black.opacity(0.2)
                    
                    HStack(spacing:0.0) {
                        Color.black.opacity(0.2)
                        Image("img_scan_camera").resizable().frame(width: widthCamera, height: widthCamera, alignment: .center)
                        Color.black.opacity(0.2)
                    }
                    .frame(width: UIScreen.screenWidth, height: widthCamera, alignment: .center)
                    .background(.clear)
                    
                    Color.black.opacity(0.2)
                }
                .background(.clear)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    @ViewBuilder private func _header(onClossed: @escaping () -> ()) -> some View {
        
        VStack(spacing:0.0){
           
            HStack{
                
                Button(action: {
                    onClossed()
                }, label: {
                    Image("btn_close_white")
                        .frame(width: 44, height: 44)
                })
                
                Spacer()
                
                Text("purchase".localized())
                    .lineLimit(2)
                    .font(.subTitle2Bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 44)
                
                Spacer()
                
                Rectangle()
                    .frame(width: 44, height: 44)
                    .foregroundColor(.clear)
                    .background(.clear)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 44)
            .background(.black.opacity(0.2))
        }
    }
}

#Preview {
    ScanQRPageView()
}
