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
    let id: UUID 
    let image: Image
}

struct ImageData: Decodable, Hashable {
    let imgUrls: [String]
}

struct UserGender {
    
}
