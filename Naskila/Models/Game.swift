//
//  Game.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import Foundation
import SwiftUI

// Константы игры
struct GameConstants {
    static let timePerLevel: TimeInterval = 60 // 1 минута на уровень
    static let customersPerLevel: Int = 8 // 8 клиентов на уровень
    static let vaseRechargeTime: TimeInterval = 10 // 10 секунд на перезарядку вазы
    static let maxFlowersPerVase: Int = 4 // Максимум 4 цветка в вазе
    static let victoryReward: Int = 200 // 200 очков за победу
    static let totalCustomersCount: Int = 13 // Всего клиентов (для выбора случайных изображений)
}

// Состояние вазы
struct VaseState: Identifiable {
    let id = UUID()
    var color: FlowerColor
    var flowers: [FlowerItem] = [] // Массив конкретных цветов
    var isDisabled: Bool = false
    var timerRemaining: Double = 0 // используем Double для более плавного отсчета, 10...0
    
    // Количество цветов в вазе
    var count: Int {
        return flowers.count
    }
    
    // Очищает вазу
    mutating func clear() {
        flowers = []
        isDisabled = false
        timerRemaining = 0
    }
    
    // Добавляет цветок в вазу
    mutating func addFlower() -> Bool {
        guard count < GameConstants.maxFlowersPerVase else { return false }
        let flower = FlowerItem.random(color: color)
        flowers.append(flower)
        isDisabled = true
        timerRemaining = GameConstants.vaseRechargeTime
        return true
    }
    
    // Берет цветок из вазы
    mutating func takeFlower() -> FlowerItem? {
        guard count > 0, !isDisabled else { return nil }
        return flowers.popLast()
    }
    
    // Обновляет таймер
    mutating func updateTimer(delta: Double) {
        if timerRemaining > 0 {
            timerRemaining -= delta
            if timerRemaining <= 0 {
                timerRemaining = 0
                isDisabled = false
            }
        }
    }
}

// Перечисление для игровых состояний (оверлеи)
enum GameOverlay {
    case none
    case pause
    case victory
    case defeat
}

// Модель для клиента
struct Customer: Identifiable {
    let id: Int
    let imageName: String
    
    // Генерирует случайного клиента из доступных
    static func random() -> Customer {
        let customerId = Int.random(in: 1...GameConstants.totalCustomersCount)
        return Customer(
            id: customerId,
            imageName: "customer\(customerId)"
        )
    }
}

// Тип перехода для анимации клиентов
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
