//
//  Customer.swift
//  Naskila
//
//  Created by Alex on 17.03.2025.
//

import SwiftUI

struct Customer: Identifiable {
    let id: Int
    let imageName: String
    
    var imageResource: ImageResource {
        switch id {
        case 1: return .customer1
        case 2: return .customer2
        case 3: return .customer3
        case 4: return .customer4
        case 5: return .customer5
        case 6: return .customer6
        case 7: return .customer7
        case 8: return .customer8
        case 9: return .customer9
        case 10: return .customer10
        case 11: return .customer11
        case 12: return .customer12
        case 13: return .customer13
        default: return .customer1
        }
    }
    
    static func random() -> Customer {
        let customerId = Int.random(in: 1...GameConstants.totalCustomersCount)
        return Customer(
            id: customerId,
            imageName: "customer\(customerId)"
        )
    }
}

enum CustomerTransition {
    case none
    case entering
    case leaving
    
    var animation: Animation {
        switch self {
        case .none:
            return .default
        case .entering:
            return .easeIn(duration: 0.5)
        case .leaving:
            return .easeOut(duration: 0.5)
        }
    }
    
    var offset: CGFloat {
        switch self {
        case .none:
            return 0
        case .entering:
            return 100
        case .leaving:
            return -100
        }
    }
}
