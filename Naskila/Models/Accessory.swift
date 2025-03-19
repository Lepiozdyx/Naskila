//
//  Accessory.swift
//  Naskila
//
//  Created by Alex on 17.03.2025.
//

import Foundation

enum AccessoryType: String, CaseIterable, Identifiable {
    case wrapping, ribbon, glitter, card
    
    var id: String { self.rawValue }
    
    var displayName: [ImageResource] {
        switch self {
        case .wrapping: return [.paper1]
        case .ribbon: return [.ribbon]
        case .glitter: return [.glitter]
        case .card: return [.card1, .card2, .card3]
        }
    }
    
    func isActive(for order: Order) -> Bool {
        switch self {
        case .wrapping: return order.needWrapping
        case .ribbon: return order.needRibbon
        case .glitter: return order.needGlitter
        case .card: return order.needCard
        }
    }
    
    func randomImage() -> ImageResource {
        return displayName.randomElement()!
    }
}

struct AccessoryItem: Identifiable {
    let id = UUID()
    let type: AccessoryType
    let image: ImageResource
    
    static func random(type: AccessoryType) -> AccessoryItem {
        return AccessoryItem(type: type, image: type.randomImage())
    }
}
