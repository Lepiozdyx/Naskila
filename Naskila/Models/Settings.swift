//
//  Settings.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import Foundation

class GameSettings: ObservableObject {
    static let shared = GameSettings()
    
    private var isUpdatingSettings = false
    
    @Published var soundEnabled: Bool = false {
        didSet {
            guard !isUpdatingSettings else { return }
            isUpdatingSettings = true
            saveSettings()
            NotificationCenter.default.post(name: .soundSettingChanged, object: soundEnabled)
            isUpdatingSettings = false
        }
    }
    
    @Published var musicEnabled: Bool = false {
        didSet {
            guard !isUpdatingSettings else { return }
            isUpdatingSettings = true
            saveSettings()
            NotificationCenter.default.post(name: .musicSettingChanged, object: musicEnabled)
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
    
    func loadSettings() {
        let defaults = UserDefaults.standard
        
        soundEnabled = defaults.bool(forKey: "soundEnabled")
        musicEnabled = defaults.bool(forKey: "musicEnabled")
        currency = defaults.integer(forKey: "currency")
        hearts = defaults.integer(forKey: "hearts") != 0 ? defaults.integer(forKey: "hearts") : GameConstants.initialHearts
        
        NotificationCenter.default.post(name: .settingsLoaded, object: nil)
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
    
    func toggleSound() {
        soundEnabled.toggle()
    }
    
    func toggleMusic() {
        musicEnabled.toggle()
    }
    
    func playSound() {
        if soundEnabled {
            SoundManager.shared.playSound()
        }
    }
}

extension Notification.Name {
    static let soundSettingChanged = Notification.Name("soundSettingChanged")
    static let musicSettingChanged = Notification.Name("musicSettingChanged")
    static let settingsLoaded = Notification.Name("settingsLoaded")
}
