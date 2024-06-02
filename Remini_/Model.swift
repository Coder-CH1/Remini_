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

struct SectionOneData: Identifiable {
    let id: UUID
    let image: UIImage
    let title: String
}

struct SectionFourData: Identifiable {
    let id: UUID
    let image: UIImage
    let title: String
    let icon: UIImage
}

struct SectionZeroData: Identifiable {
    let id: UUID    
    let image: UIImage
}
