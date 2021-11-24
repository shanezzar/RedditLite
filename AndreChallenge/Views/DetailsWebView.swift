//
//  DetailsWebView.swift
//  AndreChallenge
//
//  Created by Shanezzar Sharon on 24/11/2021.
//

import SwiftUI

struct DetailsWebView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsWebView(url: "https://www.apple.com/")
    }
}

struct DetailsWebView: View {
    @Environment(\.dismiss) var dismiss
    
    // MARK:- variables
    var url: String
    
    // MARK:- views
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Button {
                    haptic()
                    dismiss()
                } label: {
                    Image("arrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, alignment: .center)
                        .rotationEffect(Angle(degrees: -90))
                }
                
                Spacer()
                
                Text("Details")
                    .foregroundColor(.titleColor)
                    .font(Font.custom(CustomFont.sofiaProSemiBold, size: 23))
            }
            .padding(.horizontal, 32)
            .padding(.top, 64)
            .padding(.bottom, 16)
            
            WebView(request: url)
            
            Spacer()
            
                .navigationBarTitle("")
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
        }
        .edgesIgnoringSafeArea(.all)
        
    }
    
}
