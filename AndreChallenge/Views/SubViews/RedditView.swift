//
//  RedditView.swift
//  AndreChallenge
//
//  Created by Shanezzar Sharon on 24/11/2021.
//

import SwiftUI

struct RedditView_Previews: PreviewProvider {
    static var previews: some View {
        RedditView(reddit: Reddit(title: "", selfText: "", url: "", ups: 0, downs: 0))
    }
}

struct RedditView: View {
    
    // MARK:- variables
    var reddit: Reddit
    
    @State private var action: Int? = 0
    @State private var showMore: Bool = false
    
    // MARK:- views
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    
                    Image(systemName: "globe")
                        .foregroundColor(.blue)
                        .frame(width: 24, height: 24, alignment: .center)
                    
                    Image("arrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 8, alignment: .center)
                        .rotationEffect(Angle(degrees: 90))
                }
                .onTapGesture {
                    haptic()
                    action = 1
                }
                
                Text(reddit.title)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.titleColor)
                    .font(Font.custom(CustomFont.sofiaProSemiBold, size: 19))
                    .lineSpacing(6)
                    .lineLimit(.max)
                    .padding(.vertical, 8)
                
                Text(reddit.selfText.markdownToAttributed())
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.bodyColor)
                    .font(Font.custom(CustomFont.sofiaProLight, size: 13))
                    .lineSpacing(4)
                    .lineLimit(showMore ? .max : 8)
            }
            .padding(24)
            .padding(.bottom, 24)
            
            HStack {
                Image("arrow")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16, alignment: .center)
                
                Text(reddit.ups.description)
                    .foregroundColor(.bodyColor)
                    .font(Font.custom(CustomFont.sofiaProSemiBold, size: 13))
                    .padding(.trailing, 16)
                
                Image("arrow")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16, alignment: .center)
                    .rotationEffect(Angle(degrees: 180))
                
                Text(reddit.downs.description)
                    .foregroundColor(.bodyColor)
                    .font(Font.custom(CustomFont.sofiaProSemiBold, size: 13))
                
                Spacer()
                
                Text(showMore ? "hide more..." : "show more...")
                    .foregroundColor(.titleColor)
                    .font(Font.custom(CustomFont.sofiaProMedium, size: 13))
                    .onTapGesture {
                        haptic()
                        withAnimation {
                            showMore.toggle()
                        }
                    }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.cardColor)
                    .shadow(color: Color.titleColor.opacity(0.15), radius: 8, x: 0, y: 6))
            .padding(.horizontal, 16)
            .padding(.bottom, -24)
            
            NavigationLink(destination: DetailsWebView(url: reddit.url), tag: 1, selection: $action) {
                EmptyView()
            }
            .isDetailLink(false)
            .hidden()
            
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.cardColor)
                .shadow(color: Color.titleColor.opacity(0.15), radius: 8, x: 0, y: 6))
        .padding(.top, 8)
        .padding(.bottom, 16)
        
    }
    
}
