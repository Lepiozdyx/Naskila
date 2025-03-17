//
//  BouquetView.swift
//  Naskila
//
//  Created by Alex on 16.03.2025.
//

import SwiftUI

struct BouquetView: View {
    let bouquet: Bouquet
    
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
            // Show wrapping if present
            if let wrappingImage = wrappingImage {
                Image(wrappingImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200)
            } else {
                Image(.paper1)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200)
            }
            
            // Show flowers
            let allFlowers = bouquet.allFlowers
            if !allFlowers.isEmpty {
                HStack(spacing: -20) {
                    ForEach(allFlowers) { flower in
                        Image(flower.image)
                            .resizable()
                            .frame(width: 45, height: 105)
                    }
                }
                .frame(maxWidth: 200)
            }
            
            // Show ribbon if present
            if let ribbonImage = ribbonImage {
                Image(ribbonImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75)
                    .offset(x: 10, y: 75)
            }
            
            // Show glitter if present
            if let glitterImage = glitterImage {
                Image(glitterImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .offset(y: -40)
            }
            
            // Show card if present
            if let cardImage = bouquet.card?.image {
                Image(cardImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .offset(x: 75, y: 50)
            }
        }
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
    previewBouquet.addAccessory(item: AccessoryItem(type: .wrapping, image: .paper22))
    previewBouquet.addAccessory(item: AccessoryItem(type: .ribbon, image: .ribbon1))
    previewBouquet.addAccessory(item: AccessoryItem(type: .glitter, image: .glitter4))
    previewBouquet.addAccessory(item: AccessoryItem(type: .card, image: .card1))
    
    return BouquetView(bouquet: previewBouquet)
}

// MARK: - Finished Bouquet
struct FinishedBouquetView: View {
    var body: some View {
        ZStack {
            Image(.paper11)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 150)
            
            // Picked flowers
            VStack(spacing: -45) {
                HStack(spacing: -30) {
                    Image(.flowerPink)
                        .resizable()
                        .frame(width: 45, height: 85)
                    Image(.flowerRed)
                        .resizable()
                        .frame(width: 60, height: 85)
                        .scaleEffect(x: -1)
                    Image(.flowerPink)
                        .resizable()
                        .frame(width: 45, height: 85)
                        .offset(y: -25)
                    Image(.flowerPink)
                        .resizable()
                        .frame(width: 45, height: 85)
                        .offset(y: -25)
                        .scaleEffect(x: -1)
                    Image(.flowerRed)
                        .resizable()
                        .frame(width: 45, height: 85)
                        .offset(y: -15)
                    Image(.flowerBlue)
                        .resizable()
                        .frame(width: 55, height: 85)
                    
                }
                
                HStack(spacing: -20) {
                    Image(.flowerWhite)
                        .resizable()
                        .frame(width: 45, height: 85)
                    Image(.flowerWhite)
                        .resizable()
                        .frame(width: 45, height: 85)
                        .offset(y: -35)
                    Image(.flowerBlue)
                        .resizable()
                        .frame(width: 45, height: 85)
                        .offset(y: -25)
                    Image(.flowerBlue)
                        .resizable()
                        .frame(width: 45, height: 85)
                        .scaleEffect(x: -1)
                }
            }
            .offset(y: -30)
            
            Image(.paper111)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 150)
                .offset(y: 35)
                .overlay(alignment: .bottom) {
                    Image(.ribbon1)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75)
                        .offset(x: 10, y: 30)
                }
        }
    }
}
