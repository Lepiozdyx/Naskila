//
//  Settings.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import Foundation

// Настройки игры
struct GameSettings {
    var soundEnabled: Bool = true
    var musicEnabled: Bool = true
    var currency: Int = 0 // Количество заработанной внутриигровой валюты
    
    // Загрузка из UserDefaults
    static func load() -> GameSettings {
        let defaults = UserDefaults.standard
        
        return GameSettings(
            soundEnabled: defaults.bool(forKey: "soundEnabled"),
            musicEnabled: defaults.bool(forKey: "musicEnabled"),
            currency: defaults.integer(forKey: "currency")
        )
    }
    
    // Сохранение в UserDefaults
    func save() {
        let defaults = UserDefaults.standard
        
        defaults.set(soundEnabled, forKey: "soundEnabled")
        defaults.set(musicEnabled, forKey: "musicEnabled")
        defaults.set(currency, forKey: "currency")
    }
    
    // Добавление валюты
    mutating func addCurrency(_ amount: Int) {
        currency += amount
        save()
    }
}
