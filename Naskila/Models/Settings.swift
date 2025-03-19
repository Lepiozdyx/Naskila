//
//  Settings.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import Foundation
import Combine

class GameSettings: ObservableObject {
    static let shared = GameSettings()
    
    @Published var soundEnabled: Bool = true
    @Published var musicEnabled: Bool = true
    @Published var currency: Int = 0
    @Published var hearts: Int = GameConstants.initialHearts
    
    private init() {
        load()
    }
    
    func load() {
        let defaults = UserDefaults.standard
        
        soundEnabled = defaults.bool(forKey: "soundEnabled")
        musicEnabled = defaults.bool(forKey: "musicEnabled")
        currency = defaults.integer(forKey: "currency")
        hearts = defaults.integer(forKey: "hearts") != 0 ? defaults.integer(forKey: "hearts") : GameConstants.initialHearts
    }
    
    func save() {
        let defaults = UserDefaults.standard
        
        defaults.set(soundEnabled, forKey: "soundEnabled")
        defaults.set(musicEnabled, forKey: "musicEnabled")
        defaults.set(currency, forKey: "currency")
        defaults.set(hearts, forKey: "hearts")
    }
    
    func addCurrency(_ amount: Int) {
        currency += amount
        save()
    }
    
    func addHearts(_ amount: Int) {
        hearts += amount
        save()
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
            save()
            return true
        }
        return false
    }
}
