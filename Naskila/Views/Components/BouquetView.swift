//
//  BouquetView.swift
//  Naskila
//
//  Created by Alex on 16.03.2025.
//

import SwiftUI

struct BouquetView: View {
    let bouquet: Bouquet
    let packagingState: BouquetPackagingState
    
    private var wrappingImage: ImageResource? {
        bouquet.wrapping?.image
    }
    
    private var ribbonImage: ImageResource? {
        bouquet.ribbon?.image
    }
    
    private var glitterImage: ImageResource? {
        bouquet.glitter?.image
    }
    
    private var cardImage: ImageResource? {
        bouquet.card?.image
    }
    
    var body: some View {
        ZStack {
            if hasBouquetElements {
                switch packagingState {
                case .notPacked, .packing:
                    unpackedBouquetView
                case .packed:
                    packedBouquetView
                }
            }
        }
        .animation(.easeInOut(duration: 0.5), value: packagingState)
    }
    
    // MARK: - Вспомогательные представления
    
    // Представление для несобранного букета (используется для .notPacked и .packing)
    private var unpackedBouquetView: some View {
        ZStack {
            // Обычная обертка (если есть)
            if let wrappingImage = wrappingImage {
                Image(wrappingImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 200)
                    .transition(.opacity)
            }
            
            // Показываем все цветы
            flowersView
            
            // Показываем глиттер
            if let glitterImage = glitterImage {
                Image(glitterImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .offset(y: -40)
            }
            
            // Лента если есть
            if let ribbonImage = ribbonImage {
                Image(ribbonImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .offset(x: -40, y: 50)
            }
            
            // Показываем открытку
            if let cardImage = cardImage {
                Image(cardImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45)
                    .offset(x: 40, y: 50)
            }
        }
    }
    
    // Представление для упакованного букета
    private var packedBouquetView: some View {
        ZStack {
            // Нижняя часть обертки (первый слой)
            Image(.paper2)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 200)
            
            // Показываем все цветы между слоями обертки
            flowersView
            
            // Верхняя часть обертки (последний слой)
            Image(.paper3)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 100)
                .offset(y: 50)
                .overlay(alignment: .bottom) {
                    if let ribbonImage = ribbonImage {
                        Image(ribbonImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90)
                            .offset(x: 10, y: 45)
                    }
                }
                .transition(.opacity)
            
            // Показываем глиттер
            if let glitterImage = glitterImage {
                Image(glitterImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .offset(y: -40)
            }
            
            // Показываем открытку
            if let cardImage = cardImage {
                Image(cardImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45)
                    .offset(x: 45, y: 50)
            }
        }
    }
    
    // Общее представление для цветов, используемое во всех состояниях
    private var flowersView: some View {
        Group {
            let allFlowers = bouquet.allFlowers
            if !allFlowers.isEmpty {
                HStack(spacing: -20) {
                    ForEach(allFlowers) { flower in
                        Image(flower.image)
                            .resizable()
                            .frame(width: 45, height: 105)
                            .offset(y: -35)
                    }
                }
                .frame(maxWidth: 200)
            }
        }
    }
    
    // Проверка, содержит ли букет какие-либо элементы (цветы или аксессуары)
    private var hasBouquetElements: Bool {
        return !bouquet.allFlowers.isEmpty ||
               bouquet.wrapping != nil ||
               bouquet.ribbon != nil ||
               bouquet.glitter != nil ||
               bouquet.card != nil
    }
}

#Preview {
    let bouquet = Bouquet()
    let redFlower = FlowerItem(color: .red, image: .flowerRed)
    let blueFlower = FlowerItem(color: .blue, image: .flowerBlue)
    let pinkFlower = FlowerItem(color: .pink, image: .flowerPink)
    
    var previewBouquet = bouquet
    previewBouquet.addFlower(item: redFlower)
    previewBouquet.addFlower(item: blueFlower)
    previewBouquet.addFlower(item: pinkFlower)
    previewBouquet.addAccessory(item: AccessoryItem(type: .wrapping, image: .paper1))
    previewBouquet.addAccessory(item: AccessoryItem(type: .ribbon, image: .ribbon))
    previewBouquet.addAccessory(item: AccessoryItem(type: .glitter, image: .glitter))
    previewBouquet.addAccessory(item: AccessoryItem(type: .card, image: .card1))
    
    return BouquetView(bouquet: previewBouquet, packagingState: .packing)
//    return BouquetView(bouquet: previewBouquet, packagingState: .packed)
}
