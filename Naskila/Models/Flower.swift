//
//  Flower.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import Foundation

enum FlowerColor: String, CaseIterable, Identifiable {
    case red, white, blue, pink
    
    var id: String { self.rawValue }
    
    var displayName: ImageResource {
        switch self {
        case .red: return .flowerRed
        case .white: return .flowerWhite
        case .blue: return .flowerBlue
        case .pink: return .flowerPink
        }
    }
}

struct FlowerItem: Identifiable {
    let id = UUID()
    let color: FlowerColor
    let image: ImageResource
    
    static func random(color: FlowerColor) -> FlowerItem {
        return FlowerItem(color: color, image: color.displayName)
    }
}
