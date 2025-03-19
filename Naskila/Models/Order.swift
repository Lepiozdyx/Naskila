//
//  Order.swift
//  Naskila
//
//  Created by Alex on 17.03.2025.
//

import Foundation

struct Order {
    let redFlowers: Int
    let whiteFlowers: Int
    let blueFlowers: Int
    let pinkFlowers: Int
    let needWrapping: Bool
    let needRibbon: Bool
    let needGlitter: Bool
    let needCard: Bool
    
    func flowerCount(for color: FlowerColor) -> Int {
        switch color {
        case .red: return redFlowers
        case .white: return whiteFlowers
        case .blue: return blueFlowers
        case .pink: return pinkFlowers
        }
    }
    
    func needsAccessory(_ type: AccessoryType) -> Bool {
        switch type {
        case .wrapping: return needWrapping
        case .ribbon: return needRibbon
        case .glitter: return needGlitter
        case .card: return needCard
        }
    }
    
    static func random() -> Order {
        let maxTotalFlowers = 4
        
        let totalFlowersInOrder = Int.random(in: 1...maxTotalFlowers)
        
        var flowerTypes = [Int](repeating: 0, count: 4) // red, white, blue, pink
        
        let firstFlowerType = Int.random(in: 0..<4)
        flowerTypes[firstFlowerType] = 1
        
        var remainingFlowers = totalFlowersInOrder - 1
        while remainingFlowers > 0 {
            let randomType = Int.random(in: 0..<4)
            
            if flowerTypes[randomType] < 3 {
                flowerTypes[randomType] += 1
                remainingFlowers -= 1
            }
        }
        
        return Order(
            redFlowers: flowerTypes[0],
            whiteFlowers: flowerTypes[1],
            blueFlowers: flowerTypes[2],
            pinkFlowers: flowerTypes[3],
            needWrapping: true,
            needRibbon: Bool.random(),
            needGlitter: Bool.random(),
            needCard: Bool.random()
        )
    }
}
