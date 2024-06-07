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

struct ImageData: Codable, Identifiable, Hashable {
    let id: UUID 
    let imgUrls: [String]
}

