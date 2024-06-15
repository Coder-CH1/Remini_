//
//  Model.swift
//  Remini_
//
//  Created by Mac on 30/05/2024.
//

import Foundation
import SwiftUI

struct SeeAllCellData: Identifiable {
    let id: UUID
    let image: UIImage
    let title: String
    let details: String
}

struct SectionZeroData: Identifiable {
    let id: UUID    
    let image: UIImage
}

struct AssetImageArray: Identifiable {
    var id = UUID()
    static let shared = AssetImageArray(image: Image(""))
    var image: Image
}

struct ImageData: Decodable, Hashable {
    let imgUrls: [String]
}

struct AppImageModel: Hashable, Identifiable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(text1)
        hasher.combine(text2)
    }
    static func == (lhs: AppImageModel, rhs: AppImageModel) -> Bool {
        lhs.text1 == rhs.text1 && lhs.text2 == rhs.text2
    }
    var id = UUID()
    let image: String
    let text1: String
    let text2: String
    let buttonImage1: String
    let buttonImage2: String
    let buttonAction: () -> Void
}

class AppImageData: ObservableObject {
    @Published var imageData: [AppImageModel] = [
        AppImageModel(image: "img1", text1: "AI PHOTOS", text2: "", buttonImage1: "circle", buttonImage2: "checkmark.circle.fill", buttonAction: {
                }),
                AppImageModel(image: "img2", text1: "AI PHOTOS", text2: "Random text", buttonImage1: "circle", buttonImage2: "checkmark.circle.fill", buttonAction: {
                }),
                AppImageModel(image: "img3", text1: "AI PHOTOS", text2: "Random text", buttonImage1: "circle", buttonImage2: "checkmark.circle.fill", buttonAction: {
                }),
                AppImageModel(image: "img4", text1: "AI PHOTOS", text2: "Random text", buttonImage1: "circle", buttonImage2: "checkmark.circle.fill", buttonAction: {
                }),
                AppImageModel(image: "img5", text1: "AI PHOTOS", text2: "Random text", buttonImage1: "circle", buttonImage2:  "checkmark.circle.fill", buttonAction: {
                }),
                AppImageModel(image: "img6", text1: "AI PHOTOS", text2: "Random text", buttonImage1: "circle", buttonImage2:  "checkmark.circle.fill", buttonAction: {
        })
    ]
}
