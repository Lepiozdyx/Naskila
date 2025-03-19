//
//  Settings.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import Foundation
import Combine

class GameSettings: ObservableObject {
    // Статический экземпляр для реализации шаблона синглтон
    static let shared = GameSettings()
    
    @Published var soundEnabled: Bool = true
    @Published var musicEnabled: Bool = true
    @Published var currency: Int = 0 // Количество заработанной внутриигровой валюты
    @Published var hearts: Int = GameConstants.initialHearts // Количество сердечек
    
    // Приватный инициализатор для паттерна синглтон
    private init() {
        load()
    }
    
    // Загрузка из UserDefaults
    func load() {
        let defaults = UserDefaults.standard
        
        soundEnabled = defaults.bool(forKey: "soundEnabled")
        musicEnabled = defaults.bool(forKey: "musicEnabled")
        currency = defaults.integer(forKey: "currency")
        hearts = defaults.integer(forKey: "hearts") != 0 ? defaults.integer(forKey: "hearts") : GameConstants.initialHearts
    }
    
    // Сохранение в UserDefaults
    func save() {
        let defaults = UserDefaults.standard
        
        defaults.set(soundEnabled, forKey: "soundEnabled")
        defaults.set(musicEnabled, forKey: "musicEnabled")
        defaults.set(currency, forKey: "currency")
        defaults.set(hearts, forKey: "hearts")
    }
    
    // Добавление валюты
    func addCurrency(_ amount: Int) {
        currency += amount
        save()
    }
    
    // Добавление сердечек
    func addHearts(_ amount: Int) {
        hearts += amount
        save()
    }
    
    // Проверка, достаточно ли валюты для покупки
    func canAfford(_ price: Int) -> Bool {
        return currency >= price
    }
    
    // Проверка, можно ли начать игру (наличие сердечек)
    func canStartGame() -> Bool {
        return hearts > 0
    }
    
    // Покупка сердечек
    func purchaseHearts(count: Int, price: Int) -> Bool {
        if canAfford(price) {
            currency -= price
            hearts += count
            save()
            return true
        }
        return false
    }
}
