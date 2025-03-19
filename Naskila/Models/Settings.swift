//
//  Settings.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import Foundation

class GameSettings: ObservableObject {
    static let shared = GameSettings()
    
    // Флаг для предотвращения рекурсивных вызовов
    private var isUpdatingSettings = false
    
    @Published var soundEnabled: Bool = false {
        didSet {
            // Предотвращаем рекурсивные вызовы
            guard !isUpdatingSettings else { return }
            isUpdatingSettings = true
            
            // Вместо прямого вызова SoundManager из didSet, просто сохраняем настройку
            saveSettings()
            
            isUpdatingSettings = false
        }
    }
    
    @Published var musicEnabled: Bool = false {
        didSet {
            // Предотвращаем рекурсивные вызовы
            guard !isUpdatingSettings else { return }
            isUpdatingSettings = true
            
            // Применяем настройку музыки
            if musicEnabled {
                SoundManager.shared.playBackgroundMusic()
            } else {
                SoundManager.shared.stopBackgroundMusic()
            }
            
            saveSettings()
            
            isUpdatingSettings = false
        }
    }
    
    @Published var currency: Int = 0 {
        didSet {
            saveSettings()
        }
    }
    
    @Published var hearts: Int = GameConstants.initialHearts {
        didSet {
            saveSettings()
        }
    }
    
    private init() {
        loadSettings()
    }
    
    // Переименовал методы для большей ясности
    func loadSettings() {
        let defaults = UserDefaults.standard
        
        // Загружаем состояния с дефолтными значениями false
        soundEnabled = defaults.bool(forKey: "soundEnabled")
        musicEnabled = defaults.bool(forKey: "musicEnabled")
        currency = defaults.integer(forKey: "currency")
        hearts = defaults.integer(forKey: "hearts") != 0 ? defaults.integer(forKey: "hearts") : GameConstants.initialHearts
        
        // Применяем настройки музыки при загрузке, если она включена
        if musicEnabled {
            SoundManager.shared.playBackgroundMusic()
        }
    }
    
    func saveSettings() {
        let defaults = UserDefaults.standard
        defaults.set(soundEnabled, forKey: "soundEnabled")
        defaults.set(musicEnabled, forKey: "musicEnabled")
        defaults.set(currency, forKey: "currency")
        defaults.set(hearts, forKey: "hearts")
    }
    
    func addCurrency(_ amount: Int) {
        currency += amount
    }
    
    func addHearts(_ amount: Int) {
        hearts += amount
    }
    
    func canAfford(_ price: Int) -> Bool {
        return currency >= price
    }
    
    func canStartGame() -> Bool {
        return hearts > 0
    }
    
    func purchaseHearts(count: Int, price: Int) -> Bool {
        if canAfford(price) {
            currency -= price
            hearts += count
            return true
        }
        return false
    }
    
    // Четко разделенные методы для управления настройками
    func toggleSound() {
        soundEnabled.toggle()
    }
    
    func toggleMusic() {
        musicEnabled.toggle()
    }
    
    // Метод для воспроизведения звука, если он включен
    func playSound() {
        if soundEnabled {
            SoundManager.shared.playSound()
        }
    }
}
