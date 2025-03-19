//
//  Game.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import Foundation

struct GameConstants {
    static let timePerLevel: TimeInterval = 60 // 1 минута на уровень
    static let customersPerLevel: Int = 5 // 5 клиентов на уровень
    static let vaseRechargeTime: TimeInterval = 5 // 5 секунд на перезарядку вазы
    static let maxFlowersPerVase: Int = 4 // Максимум 4 цветка в вазе
    static let victoryReward: Int = 200 // 200 очков за победу
    static let orderCompletionReward: Int = 100 // Награда за выполнение заказа
    static let totalCustomersCount: Int = 13 // Всего клиентов (для выбора случайных изображений)
    
    // Сonstants for the hearts system
    static let initialHearts: Int = 15 // Начальное количество сердец
    static let heartRewardPerVictory: Int = 1 // Сердца за победу
    static let heartPenaltyPerDefeat: Int = 1 // Сердца, теряемые при поражении
    
    // Shop prices for hearts
    static let heartsPrice2: Int = 10000
    static let heartsPrice5: Int = 15000
    static let heartsPrice7: Int = 25000
    static let heartsPrice10: Int = 50000
}

enum GameOverlay {
    case none
    case pause
    case victory
    case defeat
}

// отслеживаем состояния упаковки букета
enum BouquetPackagingState {
    case notPacked
    case packing
    case packed
}
