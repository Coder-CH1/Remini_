//
//  ViewCoordinator.swift
//  Remini_
//
//  Created by Mac on 21/05/2024.
//

import SwiftUI
import Photos

struct ViewCoordinator: View {
    @State var isActive = false
    var body: some View {
        if !isActive {
            SplashView(isActive: $isActive)
        } else if UserDefaults.standard.onboardingScreenShown {
HomePageView(imageData: Data(), selectedCellImage: UIImage(), uiImage: UIImage(), images: [PHAsset](), selectedImage: UIImage(), selectedCellData: AppDataModel(image: "", text1: "", text2: "", buttonImage1: "", buttonImage2: "", buttonAction: {}), selected1: UIImage(), selected2: UIImage(), cellsImage: UIImage())
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

extension UserDefaults {
    var onboardingScreenShown: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "onboardingScreenShown") as? Bool) ?? false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "onboardingScreenShown")
        }
    }
}
