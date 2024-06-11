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

class ImageDataArray: ObservableObject {
    @Published var images: [String] = ["img1", "img2", "img3", "img4", "img5", "img6"]
}
