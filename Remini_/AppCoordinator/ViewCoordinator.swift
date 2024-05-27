//
//  ViewCoordinator.swift
//  Remini_
//
//  Created by Mac on 21/05/2024.
//

import SwiftUI

struct ViewCoordinator: View {
    @State var isActive = false
    var body: some View {
        if !isActive {
            SplashView(isActive: $isActive)
        } else {
            OnboardingView()
        }
    }
}

struct ViewCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        ViewCoordinator()
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: Double
    
    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func scaledFont(name: String, size: Double) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
}
