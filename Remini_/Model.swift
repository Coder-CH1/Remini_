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

class AppDataModel: ObservableObject, Identifiable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(text1)
        hasher.combine(text2)
    }
    static func == (lhs: AppDataModel, rhs: AppDataModel) -> Bool {
        lhs.text1 == rhs.text1 && lhs.text2 == rhs.text2
    }
    var id = UUID()
    var image: String
    let text1: String
    let text2: String
    let buttonImage1: String
    let buttonImage2: String
    let buttonAction: () -> Void
    
    init(id: UUID = UUID(), image: String, text1: String, text2: String, buttonImage1: String, buttonImage2: String, buttonAction: @escaping () -> Void) {
        self.id = id
        self.image = image
        self.text1 = text1
        self.text2 = text2
        self.buttonImage1 = buttonImage1
        self.buttonImage2 = buttonImage2
        self.buttonAction = buttonAction
    }
}
class Data: ObservableObject {
     @Published var imageData: [AppDataModel] = [
        AppDataModel(id: UUID(), image: "img1", text1: "AI PHOTOS", text2: "Enhance Your Photos", buttonImage1: "circle", buttonImage2: "checkmark.circle.fill", buttonAction: {
            }),
        AppDataModel(id: UUID(), image: "img2", text1: "AI PHOTOS", text2: "Aging Video", buttonImage1: "circle", buttonImage2: "checkmark.circle.fill", buttonAction: {
            }),
        AppDataModel(id: UUID(), image: "img3", text1: "AI PHOTOS", text2: "Business Headshots", buttonImage1: "circle", buttonImage2: "checkmark.circle.fill", buttonAction: {
            }),
        AppDataModel(id: UUID(), image: "img4", text1: "AI PHOTOS", text2: "Old Money Filter", buttonImage1: "circle", buttonImage2: "checkmark.circle.fill", buttonAction: {
            }),
        AppDataModel(id: UUID(), image: "img5", text1: "AI PHOTOS", text2: "Videogames filters", buttonImage1: "circle", buttonImage2:  "checkmark.circle.fill", buttonAction: {
            }),
        AppDataModel(id: UUID(), image: "img6", text1: "AI PHOTOS", text2: "Fix Blurry Photos", buttonImage1: "circle", buttonImage2:  "checkmark.circle.fill", buttonAction: {
            })
    ]
}

class SharedViewModel {
    @Published var selectedImages: [UIImage] = []
}

//class UserObject: Object {
//    @Persisted var selectedGender: String = ""
//}
