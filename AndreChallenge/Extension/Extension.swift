//
//  Extension.swift
//  AndreChallenge
//
//  Created by Shanezzar Sharon on 24/11/2021.
//

import SwiftUI

extension Color {
    static var titleColor = Color("title-color")
    
    static var cardColor = Color("card-color")
    
    static var bodyColor = Color("body-color")
    
//    static var appBlueLineLight = Color("color-blue-line-light")
//
//    static var appBlueLineDark = Color("color-blue-line-dark")
//
//    static var appLightGray = Color("color-light-gray")
//
//    static var appTagBackgroundBlue = Color("color-tag-background-blue")
//
//    static var appDarkBlue = Color("color-dark-blue")
    
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func haptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let impactMed = UIImpactFeedbackGenerator(style: style)
        impactMed.impactOccurred()
    }
    
}

extension String {
    func markdownToAttributed() -> AttributedString {
        do {
            return try AttributedString(markdown: self) /// convert to AttributedString
        } catch {
            return AttributedString("Error parsing markdown: \(error)")
        }
    }
    
}
