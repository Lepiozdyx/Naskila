//
//  Flower.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import Foundation

// Перечисление для цветов цветов
enum FlowerColor: String, CaseIterable, Identifiable {
    case red, white, blue, pink
    
    var id: String { self.rawValue }
    
    var displayName: [ImageResource] {
        switch self {
        case .red: return [.flowerRed1, .flowerRed2]
        case .white: return [.flowerWhite1, .flowerWhite2]
        case .blue: return [.flowerBlue1, .flowerBlue2, .flowerBlue3]
        case .pink: return [.flowerPink1, .flowerPink2]
        }
    }
    
    // Получение случайного изображения цветка данного цвета
    func randomImage() -> ImageResource {
        return displayName.randomElement()!
    }
}

// Структура для хранения конкретного цветка с выбранным изображением
struct FlowerItem: Identifiable {
    let id = UUID()
    let color: FlowerColor
    let image: ImageResource
    
    // Создание случайного цветка данного цвета
    static func random(color: FlowerColor) -> FlowerItem {
        return FlowerItem(color: color, image: color.randomImage())
    }
}

// Перечисление для типов аксессуаров
enum AccessoryType: String, CaseIterable, Identifiable {
    case wrapping, ribbon, glitter, card
    
    var id: String { self.rawValue }
    
    var displayName: [ImageResource] {
        switch self {
        case .wrapping: return [.paper1, .paper2, .paper3, .paper4]
        case .ribbon: return [.ribbon1, .ribbon2, .ribbon3, .ribbon4]
        case .glitter: return [.glitter1, .glitter2, .glitter3, .glitter4]
        case .card: return [.card1, .card2, .card3]
        }
    }
    
    // Проверка активности кнопки в зависимости от заказа
    func isActive(for order: Order) -> Bool {
        switch self {
        case .wrapping: return order.needWrapping
        case .ribbon: return order.needRibbon
        case .glitter: return order.needGlitter
        case .card: return order.needCard
        }
    }
    
    // Получение случайного изображения аксессуара данного типа
    func randomImage() -> ImageResource {
        return displayName.randomElement()!
    }
}

// Структура для хранения конкретного аксессуара с выбранным изображением
struct AccessoryItem: Identifiable {
    let id = UUID()
    let type: AccessoryType
    let image: ImageResource
    
    // Создание случайного аксессуара данного типа
    static func random(type: AccessoryType) -> AccessoryItem {
        return AccessoryItem(type: type, image: type.randomImage())
    }
}

// Структура для заказа
struct Order {
    let redFlowers: Int
    let whiteFlowers: Int
    let blueFlowers: Int
    let pinkFlowers: Int
    let needWrapping: Bool
    let needRibbon: Bool
    let needGlitter: Bool
    let needCard: Bool
    
    // Вспомогательный метод для получения количества цветов определенного цвета
    func flowerCount(for color: FlowerColor) -> Int {
        switch color {
        case .red: return redFlowers
        case .white: return whiteFlowers
        case .blue: return blueFlowers
        case .pink: return pinkFlowers
        }
    }
    
    // Проверяет, нужен ли конкретный аксессуар
    func needsAccessory(_ type: AccessoryType) -> Bool {
        switch type {
        case .wrapping: return needWrapping
        case .ribbon: return needRibbon
        case .glitter: return needGlitter
        case .card: return needCard
        }
    }
    
    // Метод для генерации случайного заказа
    static func random() -> Order {
        let maxFlowers = 4 // Максимальное количество цветов одного цвета
        
        // Гарантируем, что в заказе будет хотя бы один цветок
        let noFlowers = [0, 0, 0, 0]
        var flowersCount = noFlowers
        
        while flowersCount == noFlowers {
            flowersCount = [
                Int.random(in: 0...maxFlowers),
                Int.random(in: 0...maxFlowers),
                Int.random(in: 0...maxFlowers),
                Int.random(in: 0...maxFlowers)
            ]
        }
        
        return Order(
            redFlowers: flowersCount[0],
            whiteFlowers: flowersCount[1],
            blueFlowers: flowersCount[2],
            pinkFlowers: flowersCount[3],
            needWrapping: Bool.random(),
            needRibbon: Bool.random(),
            needGlitter: Bool.random(),
            needCard: Bool.random()
        )
    }
}

// Структура для букета (собираемый игроком)
struct Bouquet {
    // Массивы конкретных цветов и аксессуаров
    var redFlowers: [FlowerItem] = []
    var whiteFlowers: [FlowerItem] = []
    var blueFlowers: [FlowerItem] = []
    var pinkFlowers: [FlowerItem] = []
    var wrapping: AccessoryItem?
    var ribbon: AccessoryItem?
    var glitter: AccessoryItem?
    var card: AccessoryItem?
    
    // Добавляет цветок определенного цвета с конкретным изображением
    mutating func addFlower(item: FlowerItem) {
        switch item.color {
        case .red: redFlowers.append(item)
        case .white: whiteFlowers.append(item)
        case .blue: blueFlowers.append(item)
        case .pink: pinkFlowers.append(item)
        }
    }
    
    // Добавляет аксессуар определенного типа с конкретным изображением
    mutating func addAccessory(item: AccessoryItem) {
        switch item.type {
        case .wrapping: wrapping = item
        case .ribbon: ribbon = item
        case .glitter: glitter = item
        case .card: card = item
        }
    }
    
    // Проверяет, есть ли конкретный аксессуар
    func hasAccessory(_ type: AccessoryType) -> Bool {
        switch type {
        case .wrapping: return wrapping != nil
        case .ribbon: return ribbon != nil
        case .glitter: return glitter != nil
        case .card: return card != nil
        }
    }
    
    // Проверяет, соответствует ли букет заказу
    func matches(order: Order) -> Bool {
        return redFlowers.count == order.redFlowers &&
               whiteFlowers.count == order.whiteFlowers &&
               blueFlowers.count == order.blueFlowers &&
               pinkFlowers.count == order.pinkFlowers &&
               (wrapping != nil) == order.needWrapping &&
               (ribbon != nil) == order.needRibbon &&
               (glitter != nil) == order.needGlitter &&
               (card != nil) == order.needCard
    }
    
    // Сбрасывает букет
    mutating func reset() {
        redFlowers = []
        whiteFlowers = []
        blueFlowers = []
        pinkFlowers = []
        wrapping = nil
        ribbon = nil
        glitter = nil
        card = nil
    }
    
    // Возвращает количество цветов по цвету
    func flowerCount(for color: FlowerColor) -> Int {
        switch color {
        case .red: return redFlowers.count
        case .white: return whiteFlowers.count
        case .blue: return blueFlowers.count
        case .pink: return pinkFlowers.count
        }
    }
    
    // Получает все цветы в букете в виде одного массива
    var allFlowers: [FlowerItem] {
        return redFlowers + whiteFlowers + blueFlowers + pinkFlowers
    }
    
    // Получает все аксессуары в букете в виде массива
    var allAccessories: [AccessoryItem] {
        var accessories: [AccessoryItem] = []
        if let wrapping = wrapping { accessories.append(wrapping) }
        if let ribbon = ribbon { accessories.append(ribbon) }
        if let glitter = glitter { accessories.append(glitter) }
        if let card = card { accessories.append(card) }
        return accessories
    }
}
