//
//  Game.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import Foundation

struct GameConstants {
    static let timePerLevel: TimeInterval = 60
    static let customersPerLevel: Int = 5 // 5 customers per lvl
    static let vaseRechargeTime: TimeInterval = 5 // 5 sec vase reload
    static let maxFlowersPerVase: Int = 4
    static let victoryReward: Int = 200
    static let orderCompletionReward: Int = 100
    static let totalCustomersCount: Int = 13
    
    // Сonstants for the hearts system
    static let initialHearts: Int = 15
    static let heartRewardPerVictory: Int = 1
    static let heartPenaltyPerDefeat: Int = 1
    
    // Shop prices for hearts
    static let heartsPrice2: Int = 10_000
    static let heartsPrice5: Int = 15_000
    static let heartsPrice7: Int = 25_000
    static let heartsPrice10: Int = 50_000
}

enum GameOverlay {
    case none
    case pause
    case victory
    case defeat
}

enum BouquetPackagingState {
    case notPacked
    case packing
    case packed
}
