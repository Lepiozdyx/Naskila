//
//  Bouquet.swift
//  Naskila
//
//  Created by Alex on 17.03.2025.
//

import Foundation

struct Bouquet {
    var redFlowers: [FlowerItem] = []
    var whiteFlowers: [FlowerItem] = []
    var blueFlowers: [FlowerItem] = []
    var pinkFlowers: [FlowerItem] = []
    var wrapping: AccessoryItem?
    var ribbon: AccessoryItem?
    var glitter: AccessoryItem?
    var card: AccessoryItem?
    
    mutating func addFlower(item: FlowerItem) {
        switch item.color {
        case .red: redFlowers.append(item)
        case .white: whiteFlowers.append(item)
        case .blue: blueFlowers.append(item)
        case .pink: pinkFlowers.append(item)
        }
    }
    
    mutating func addAccessory(item: AccessoryItem) {
        switch item.type {
        case .wrapping: wrapping = item
        case .ribbon: ribbon = item
        case .glitter: glitter = item
        case .card: card = item
        }
    }
    
    func hasAccessory(_ type: AccessoryType) -> Bool {
        switch type {
        case .wrapping: return wrapping != nil
        case .ribbon: return ribbon != nil
        case .glitter: return glitter != nil
        case .card: return card != nil
        }
    }
    
    func matches(order: Order) -> Bool {
        return redFlowers.count == order.redFlowers &&
               whiteFlowers.count == order.whiteFlowers &&
               blueFlowers.count == order.blueFlowers &&
               pinkFlowers.count == order.pinkFlowers &&
               (wrapping != nil) == order.needWrapping &&
               (ribbon != nil) == order.needRibbon &&
               (glitter != nil) == order.needGlitter &&
               (card != nil) == order.needCard
    }
    
    mutating func reset() {
        redFlowers = []
        whiteFlowers = []
        blueFlowers = []
        pinkFlowers = []
        wrapping = nil
        ribbon = nil
        glitter = nil
        card = nil
    }
    
    func flowerCount(for color: FlowerColor) -> Int {
        switch color {
        case .red: return redFlowers.count
        case .white: return whiteFlowers.count
        case .blue: return blueFlowers.count
        case .pink: return pinkFlowers.count
        }
    }
    
    var allFlowers: [FlowerItem] {
        return redFlowers + whiteFlowers + blueFlowers + pinkFlowers
    }
    
    var allAccessories: [AccessoryItem] {
        var accessories: [AccessoryItem] = []
        if let wrapping = wrapping { accessories.append(wrapping) }
        if let ribbon = ribbon { accessories.append(ribbon) }
        if let glitter = glitter { accessories.append(glitter) }
        if let card = card { accessories.append(card) }
        return accessories
    }
}
