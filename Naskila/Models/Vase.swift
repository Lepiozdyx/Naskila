//
//  Vase.swift
//  Naskila
//
//  Created by Alex on 17.03.2025.
//

import Foundation

// Состояние вазы
struct VaseState: Identifiable {
    let id = UUID()
    var color: FlowerColor
    var flowers: [FlowerItem] = []
    var isDisabled: Bool = false
    var timerRemaining: Double = 0
    
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
