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
    static let vaseRechargeTime: TimeInterval = 1 // 5 секунд на перезарядку вазы
    static let maxFlowersPerVase: Int = 4 // Максимум 4 цветка в вазе
    static let victoryReward: Int = 200 // 200 очков за победу
    static let totalCustomersCount: Int = 13 // Всего клиентов (для выбора случайных изображений)
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
