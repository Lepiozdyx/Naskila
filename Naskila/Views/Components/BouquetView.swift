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
    
    var body: some View {
        ZStack {
            // Показываем разные стадии упаковки в зависимости от состояния
            switch packagingState {
            case .notPacked:
                // Обычная обертка (если есть)
                if let wrappingImage = wrappingImage {
                    Image(wrappingImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 200)
                        .transition(.opacity)
                }
                
                // Показываем цветы
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
                
                // Показываем глиттер, если не упакован
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
                        .offset(x: -60, y: 50)
                }
                
                // Показываем открытку, если не упакован
                if let cardImage = bouquet.card?.image {
                    Image(cardImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                        .offset(x: 75, y: 50)
                }
                
            case .packing:
                // Первый этап упаковки - обертка снизу
                Image(.paper1)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 200)
                    .transition(.opacity)
                
                // Показываем цветы в процессе упаковки
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
                
                // Лента если есть
                if let ribbonImage = ribbonImage {
                    Image(ribbonImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                        .offset(x: -60, y: 50)
                }
                
                // Показываем глиттер
                if let glitterImage = glitterImage {
                    Image(glitterImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .offset(y: -40)
                }
                
                // Показываем открытку
                if let cardImage = bouquet.card?.image {
                    Image(cardImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                        .offset(x: 75, y: 50)
                }
                
            case .packed:
                // Нижняя часть обертки (первый слой)
                Image(.paper2)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 200)
                
                // В упакованном состоянии показываем цветы между слоями обертки
                let allFlowers = bouquet.allFlowers
                if !allFlowers.isEmpty {
                    HStack(spacing: -20) {
                        ForEach(bouquet.allFlowers.prefix(min(3, bouquet.allFlowers.count))) { flower in
                            Image(flower.image)
                                .resizable()
                                .frame(width: 45, height: 105)
                                .offset(y: -35)
                        }
                    }
                    .frame(maxWidth: 200)
                }
                
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
                if let cardImage = bouquet.card?.image {
                    Image(cardImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                        .offset(x: 45, y: 50)
                }
            }
        }
        .animation(.easeInOut(duration: 0.5), value: packagingState)
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
    
//    return BouquetView(bouquet: previewBouquet, packagingState: .notPacked)
//    return BouquetView(bouquet: previewBouquet, packagingState: .packing)
    return BouquetView(bouquet: previewBouquet, packagingState: .packed)
}
