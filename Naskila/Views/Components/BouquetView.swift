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
        GeometryReader { geo in
            let containerSize = min(geo.size.width, geo.size.height)
            
            ZStack {
                if hasBouquetElements {
                    switch packagingState {
                    case .notPacked, .packing:
                        unpackedBouquetView(containerSize: containerSize)
                    case .packed:
                        packedBouquetView(containerSize: containerSize)
                    }
                }
            }
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
            .animation(.easeInOut(duration: 0.5), value: packagingState)
        }
    }
    
    // MARK: -
    private func unpackedBouquetView(containerSize: CGFloat) -> some View {
        ZStack {
            if let wrappingImage = wrappingImage {
                Image(wrappingImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: containerSize)
                    .transition(.opacity)
            }
            
            flowersView(containerSize: containerSize)
            
            if let glitterImage = glitterImage {
                Image(glitterImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: containerSize * 0.5)
                    .offset(y: -containerSize * 0.2)
            }
            
            if let ribbonImage = ribbonImage {
                Image(ribbonImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: containerSize * 0.25)
                    .offset(x: -containerSize * 0.2, y: containerSize * 0.25)
            }
            
            if let cardImage = cardImage {
                Image(cardImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: containerSize * 0.22)
                    .offset(x: containerSize * 0.2, y: containerSize * 0.25)
            }
        }
    }
    
    private func packedBouquetView(containerSize: CGFloat) -> some View {
        ZStack {
            Image(.paper2)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: containerSize)
            
            flowersView(containerSize: containerSize)
            
            Image(.paper3)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: containerSize * 0.5)
                .offset(y: containerSize * 0.25)
                .overlay(alignment: .bottom) {
                    if let ribbonImage = ribbonImage {
                        Image(ribbonImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: containerSize * 0.45)
                            .offset(x: containerSize * 0.05, y: containerSize * 0.22)
                    }
                }
                .transition(.opacity)
            
            if let glitterImage = glitterImage {
                Image(glitterImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: containerSize * 0.5)
                    .offset(y: -containerSize * 0.2)
            }
            
            if let cardImage = cardImage {
                Image(cardImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: containerSize * 0.22)
                    .offset(x: containerSize * 0.22, y: containerSize * 0.25)
            }
        }
    }
    
    private func flowersView(containerSize: CGFloat) -> some View {
        Group {
            let allFlowers = bouquet.allFlowers
            if !allFlowers.isEmpty {
                HStack(spacing: -containerSize * 0.1) {
                    ForEach(allFlowers) { flower in
                        Image(flower.image)
                            .resizable()
                            .frame(width: containerSize * 0.22, height: containerSize * 0.52)
                            .offset(y: -containerSize * 0.17)
                    }
                }
                .frame(maxWidth: containerSize)
            }
        }
    }
    
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
        .frame(width: 200, height: 200)
}
