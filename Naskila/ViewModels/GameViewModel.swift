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
    // MARK: - Опубликованные свойства для обновления UI
    @Published var currentOrder: Order
    @Published var currentBouquet = Bouquet()
    @Published var vases: [VaseState]
    @Published var currentCustomer: Customer
    @Published var customersServed: Int = 0
    @Published var gameOverlay: GameOverlay = .none
    @Published var remainingTime: Double
    @Published var settings: GameSettings
    @Published var customerTransition: CustomerTransition = .none
    
    // MARK: - Приватные свойства
    private var timer: AnyCancellable?
    private var vaseTimers: [UUID: AnyCancellable] = [:]
    private var isTimerRunning: Bool = false
    
    // MARK: - Инициализатор
    init() {
        // Загрузка настроек
        self.settings = GameSettings.load()
        
        // Инициализация ваз для каждого цвета
        self.vases = FlowerColor.allCases.map { VaseState(color: $0) }
        
        // Создание первого заказа и клиента
        self.currentOrder = Order.random()
        self.currentCustomer = Customer.random()
        
        // Установка времени уровня
        self.remainingTime = GameConstants.timePerLevel
        
        // Инициализация пустого букета
        self.currentBouquet = Bouquet()
    }
    
    // MARK: - Методы управления игрой
    
    /// Запускает игру и таймер
    func startGame() {
        resetGame()
        startTimer()
    }
    
    /// Сбрасывает игру в начальное состояние
    func resetGame() {
        // Сброс геймплея
        customersServed = 0
        remainingTime = GameConstants.timePerLevel
        currentOrder = Order.random()
        currentCustomer = Customer.random()
        currentBouquet = Bouquet()
        
        // Сброс ваз
        for i in 0..<vases.count {
            vases[i].clear()
        }
        
        // Сброс оверлея
        gameOverlay = .none
        
        // Отмена всех таймеров
        cancelAllTimers()
    }
    
    /// Приостанавливает игру
    func pauseGame() {
        if isTimerRunning {
            cancelAllTimers()
            gameOverlay = .pause
        }
    }
    
    /// Возобновляет игру
    func resumeGame() {
        if gameOverlay == .pause {
            gameOverlay = .none
            startTimer()
        }
    }
    
    /// Завершает уровень с победой
    private func completeLevel() {
        cancelAllTimers()
        settings.addCurrency(GameConstants.victoryReward)
        gameOverlay = .victory
    }
    
    /// Завершает уровень с поражением
    private func failLevel() {
        cancelAllTimers()
        gameOverlay = .defeat
    }
    
    // MARK: - Методы таймеров
    
    /// Запускает основной таймер уровня
    private func startTimer() {
        isTimerRunning = true
        
        timer = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                // Обновление времени уровня
                if self.remainingTime > 0 {
                    self.remainingTime -= 0.1
                    
                    // Проверка времени
                    if self.remainingTime <= 0 {
                        self.remainingTime = 0
                        
                        // Проверка условия поражения
                        if self.customersServed < GameConstants.customersPerLevel {
                            self.failLevel()
                        }
                    }
                }
                
                // Обновление таймеров ваз
                for i in 0..<self.vases.count {
                    self.vases[i].updateTimer(delta: 0.1)
                }
            }
    }
    
    /// Отменяет все таймеры
    private func cancelAllTimers() {
        isTimerRunning = false
        timer?.cancel()
    }
    
    // MARK: - Методы управления букетом
    
    /// Берет цветок из вазы указанного цвета
    func takeFlowerFromVase(color: FlowerColor) {
        // Находим вазу соответствующего цвета
        if let index = vases.firstIndex(where: { $0.color == color }) {
            // Проверяем, можно ли взять цветок
            if !vases[index].isDisabled && vases[index].count > 0 {
                // Берем цветок из вазы
                if let flower = vases[index].takeFlower() {
                    // Добавляем цветок в букет
                    currentBouquet.addFlower(item: flower)
                    
                    // Проверяем, выполнен ли заказ
                    checkOrderCompletion()
                }
            }
        }
    }
    
    /// Добавляет цветок в вазу указанного цвета
    func addFlowerToVase(color: FlowerColor) {
        // Находим вазу соответствующего цвета
        if let index = vases.firstIndex(where: { $0.color == color }) {
            // Добавляем цветок в вазу
            if vases[index].addFlower() {
                // Если есть активный таймер для этой вазы, отменяем его
                if let timer = vaseTimers[vases[index].id] {
                    timer.cancel()
                    vaseTimers.removeValue(forKey: vases[index].id)
                }
            }
        }
    }
    
    /// Добавляет аксессуар к букету
    func addAccessory(_ type: AccessoryType) {
        // Проверяем, нужен ли этот аксессуар по заказу и еще не добавлен
        if currentOrder.needsAccessory(type) && !currentBouquet.hasAccessory(type) {
            // Создаем аксессуар со случайным изображением
            let accessory = AccessoryItem.random(type: type)
            
            // Добавляем аксессуар в букет
            currentBouquet.addAccessory(item: accessory)
            
            // Проверяем, выполнен ли заказ
            checkOrderCompletion()
        }
    }
    
    /// Проверяет, соответствует ли букет заказу
    private func checkOrderCompletion() {
        if currentBouquet.matches(order: currentOrder) {
            // Заказ выполнен, обрабатываем завершение
            completeOrder()
        }
    }
    
    /// Обрабатывает завершение заказа
    private func completeOrder() {
        // Увеличиваем счетчик обслуженных клиентов
        customersServed += 1
        
        // Анимация ухода текущего клиента
        customerTransition = .leaving
        
        // Задержка для анимации
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            // Проверяем, достигнута ли цель по количеству клиентов
            if self.customersServed >= GameConstants.customersPerLevel {
                self.completeLevel()
                return
            }
            
            // Генерируем новый заказ и нового клиента
            self.currentOrder = Order.random()
            self.currentCustomer = Customer.random()
            
            // Сбрасываем букет
            self.currentBouquet.reset()
            
            // Анимация появления нового клиента
            self.customerTransition = .entering
            
            // Сброс анимации
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.customerTransition = .none
            }
        }
    }
    
    // MARK: - Вспомогательные методы
    
    /// Проверяет, активен ли определенный аксессуар для текущего заказа
    func isAccessoryActive(_ type: AccessoryType) -> Bool {
        return type.isActive(for: currentOrder)
    }
    
    /// Возвращает процент оставшегося времени
    var timePercentage: Double {
        return remainingTime / GameConstants.timePerLevel
    }
    
    /// Возвращает отформатированное оставшееся время (мм:сс)
    var formattedTime: String {
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    /// Включает/выключает звук
    func toggleSound() {
        settings.soundEnabled.toggle()
        settings.save()
    }
    
    /// Включает/выключает музыку
    func toggleMusic() {
        settings.musicEnabled.toggle()
        settings.save()
    }
}
