//
//  GameViewModel.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import Foundation
import Combine
import SwiftUI

class GameViewModel: ObservableObject {
    // MARK: - Published properties
    @Published var currentOrder: Order
    @Published var currentBouquet = Bouquet()
    @Published var vases: [VaseState]
    @Published var currentCustomer: Customer
    @Published var customersServed: Int = 0
    @Published var gameOverlay: GameOverlay = .none
    @Published var remainingTime: Double
    @ObservedObject var settings: GameSettings
    @Published var customerTransition: CustomerTransition = .none
    @Published var bouquetPackagingState: BouquetPackagingState = .notPacked
    @Published var isAchievementButtonAvailable: Bool = true  // Property for achievement button
    
    // MARK: - Private properties
    private var timer: AnyCancellable?
    private var vaseTimers: [UUID: AnyCancellable] = [:]
    private var isTimerRunning: Bool = false
    
    // MARK: - Initializer
    init() {
        // Use the shared instance of settings
        self.settings = GameSettings.shared
        
        // Initialize vases for each color
        self.vases = FlowerColor.allCases.map { VaseState(color: $0) }
        
        // Create the first order and customer
        self.currentOrder = Order.random()
        self.currentCustomer = Customer.random()
        
        // Set the level time
        self.remainingTime = GameConstants.timePerLevel
        
        // Initialize empty bouquet
        self.currentBouquet = Bouquet()
    }
    
    // MARK: - Game management methods
    
    /// Starts the game and timer
    func startGame() {
        // Check if there are enough hearts to start the game
        guard settings.canStartGame() else {
            // Exit without starting the game if not enough hearts
            gameOverlay = .none
            return
        }
        
        resetGame()
        startTimer()
        
        // Play background music when starting the game if enabled
        if settings.musicEnabled {
            SoundManager.shared.playBackgroundMusic()
        }
    }
    
    /// Resets the game to initial state
    func resetGame() {
        // Reset gameplay
        customersServed = 0
        remainingTime = GameConstants.timePerLevel
        currentOrder = Order.random()
        currentCustomer = Customer.random()
        currentBouquet = Bouquet()
        bouquetPackagingState = .notPacked
        isAchievementButtonAvailable = true  // Reset achievement button availability
        
        // Reset vases
        for i in 0..<vases.count {
            vases[i].clear()
        }
        
        // Reset overlay
        gameOverlay = .none
        
        // Cancel all timers
        cancelAllTimers()
    }
    
    /// Pauses the game
    func pauseGame() {
        if isTimerRunning {
            cancelAllTimers()
            gameOverlay = .pause
            
            // Play sound when pausing if enabled
            if settings.soundEnabled {
                SoundManager.shared.playSound()
            }
        }
    }
    
    /// Resumes the game
    func resumeGame() {
        if gameOverlay == .pause {
            gameOverlay = .none
            startTimer()
            
            // Play sound when resuming if enabled
            if settings.soundEnabled {
                SoundManager.shared.playSound()
            }
        }
    }
    
    /// Completes the level with victory
    private func completeLevel() {
        cancelAllTimers()
        // Add currency for victory
        settings.addCurrency(GameConstants.victoryReward)
        // Add heart for victory
        settings.addHearts(GameConstants.heartRewardPerVictory)
        gameOverlay = .victory
        
        // Play sound for victory if enabled
        if settings.soundEnabled {
            SoundManager.shared.playSound()
        }
    }
    
    /// Completes the level with defeat
    private func failLevel() {
        cancelAllTimers()
        // Subtract heart for defeat
        settings.addHearts(-GameConstants.heartPenaltyPerDefeat)
        gameOverlay = .defeat
        
        // Play sound for defeat if enabled
        if settings.soundEnabled {
            SoundManager.shared.playSound()
        }
    }
    
    // MARK: - Timer methods
    
    /// Starts the main level timer
    private func startTimer() {
        isTimerRunning = true
        
        timer = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                // Update level time
                if self.remainingTime > 0 {
                    self.remainingTime -= 0.1
                    
                    // Check time
                    if self.remainingTime <= 0 {
                        self.remainingTime = 0
                        
                        // Check defeat condition
                        if self.customersServed < GameConstants.customersPerLevel {
                            self.failLevel()
                        }
                    }
                }
                
                // Update vase timers
                for i in 0..<self.vases.count {
                    self.vases[i].updateTimer(delta: 0.1)
                }
            }
    }
    
    /// Cancels all timers
    private func cancelAllTimers() {
        isTimerRunning = false
        timer?.cancel()
    }
    
    // MARK: - Bouquet management methods
    
    /// Takes flower from vase of specified color
    func takeFlowerFromVase(color: FlowerColor) {
        // Find vase of corresponding color
        if let index = vases.firstIndex(where: { $0.color == color }) {
            // Check if flower can be taken
            if !vases[index].isDisabled && vases[index].count > 0 {
                // Take flower from vase
                if let flower = vases[index].takeFlower() {
                    // Add flower to bouquet
                    currentBouquet.addFlower(item: flower)
                    
                    // Play sound when taking flower if enabled
                    if settings.soundEnabled {
                        SoundManager.shared.playSound()
                    }
                    
                    // Check if order is complete
                    checkOrderCompletion()
                }
            }
        }
    }
    
    /// Adds flower to vase of specified color
    func addFlowerToVase(color: FlowerColor) {
        // Find vase of corresponding color
        if let index = vases.firstIndex(where: { $0.color == color }) {
            // Add flower to vase
            if vases[index].addFlower() {
                // Play sound when adding flower if enabled
                if settings.soundEnabled {
                    SoundManager.shared.playSound()
                }
                
                // If there is an active timer for this vase, cancel it
                if let timer = vaseTimers[vases[index].id] {
                    timer.cancel()
                    vaseTimers.removeValue(forKey: vases[index].id)
                }
            }
        }
    }
    
    /// Adds accessory to bouquet
    func addAccessory(_ type: AccessoryType) {
        // Check if this accessory is needed by the order and not already added
        if currentOrder.needsAccessory(type) && !currentBouquet.hasAccessory(type) {
            // Create accessory with random image
            let accessory = AccessoryItem.random(type: type)
            
            // Add accessory to bouquet
            currentBouquet.addAccessory(item: accessory)
            
            // Play sound when adding accessory if enabled
            if settings.soundEnabled {
                SoundManager.shared.playSound()
            }
            
            // Check if order is complete
            checkOrderCompletion()
        }
    }
    
    /// Checks if bouquet matches order
    private func checkOrderCompletion() {
        if currentBouquet.matches(order: currentOrder) {
            // Order complete, handle completion
            completeOrder()
        }
    }
    
    // MARK: - Achievement button method
    
    /// Automatically completes current order
    func useAchievementButton() {
        // Check if button is available
        guard isAchievementButtonAvailable else { return }
        
        // Play sound when using achievement if enabled
        if settings.soundEnabled {
            SoundManager.shared.playSound()
        }
        
        // Mark button as used
        isAchievementButtonAvailable = false
        
        // Create bouquet matching current order
        let completeBouquet = createCompleteBouquet(for: currentOrder)
        
        // Set assembled bouquet
        currentBouquet = completeBouquet
        
        // Complete order
        completeOrder()
    }
    
    /// Creates bouquet matching order
    private func createCompleteBouquet(for order: Order) -> Bouquet {
        var bouquet = Bouquet()
        
        // Add required number of each color flower
        for _ in 0..<order.redFlowers {
            bouquet.addFlower(item: FlowerItem.random(color: .red))
        }
        
        for _ in 0..<order.whiteFlowers {
            bouquet.addFlower(item: FlowerItem.random(color: .white))
        }
        
        for _ in 0..<order.blueFlowers {
            bouquet.addFlower(item: FlowerItem.random(color: .blue))
        }
        
        for _ in 0..<order.pinkFlowers {
            bouquet.addFlower(item: FlowerItem.random(color: .pink))
        }
        
        // Add accessories if needed
        if order.needWrapping {
            bouquet.addAccessory(item: AccessoryItem.random(type: .wrapping))
        }
        
        if order.needRibbon {
            bouquet.addAccessory(item: AccessoryItem.random(type: .ribbon))
        }
        
        if order.needGlitter {
            bouquet.addAccessory(item: AccessoryItem.random(type: .glitter))
        }
        
        if order.needCard {
            bouquet.addAccessory(item: AccessoryItem.random(type: .card))
        }
        
        return bouquet
    }
    
    /// Handles order completion
    private func completeOrder() {
        // Award currency for completing order
        settings.addCurrency(GameConstants.orderCompletionReward)
        
        // Play sound when completing order if enabled
        if settings.soundEnabled {
            SoundManager.shared.playSound()
        }
        
        // Start packaging animation
        self.bouquetPackagingState = .packing
        
        // First stage of packaging
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
            guard let self = self else { return }
            self.bouquetPackagingState = .packed
            
            // After packaging completion continue with customer animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                guard let self = self else { return }
                
                // Increase served customers counter
                self.customersServed += 1
                
                // Animation of current customer leaving
                self.customerTransition = .leaving
                
                // Delay for animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                    guard let self = self else { return }
                    
                    // Check if goal for number of customers is reached
                    if self.customersServed >= GameConstants.customersPerLevel {
                        self.completeLevel()
                        return
                    }
                    
                    // Generate new order and new customer
                    self.currentOrder = Order.random()
                    self.currentCustomer = Customer.random()
                    
                    // Reset bouquet and packaging state
                    self.currentBouquet.reset()
                    self.bouquetPackagingState = .notPacked
                    
                    // Animation of new customer entering
                    self.customerTransition = .entering
                    
                    // Reset animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.customerTransition = .none
                    }
                }
            }
        }
    }
    
    // MARK: - Helper methods
    
    // Add new clearWorkspace() method to clear work surface
    func clearWorkspace() {
        // Reset current bouquet, keeping current order
        currentBouquet.reset()
        
        // Reset bouquet packaging state
        bouquetPackagingState = .notPacked
        
        // Play sound when clearing work surface if enabled
        if settings.soundEnabled {
            SoundManager.shared.playSound()
        }
    }
    
    /// Checks if specific accessory is active for current order
    func isAccessoryActive(_ type: AccessoryType) -> Bool {
        return type.isActive(for: currentOrder)
    }
    
    /// Returns percentage of remaining time
    var timePercentage: Double {
        return remainingTime / GameConstants.timePerLevel
    }
    
    /// Returns formatted remaining time (mm:ss)
    var formattedTime: String {
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    /// Toggles sound on/off
    func toggleSound() {
        settings.toggleSound()
    }

    /// Toggles music on/off
    func toggleMusic() {
        settings.toggleMusic()
    }

    /// Plays sound if enabled
    func playSound() {
        settings.playSound()
    }
}
