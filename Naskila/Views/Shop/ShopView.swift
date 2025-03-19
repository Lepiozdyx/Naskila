//
//  ShopView.swift
//  Naskila
//
//  Created by Alex on 18.03.2025.
//

import SwiftUI

struct ShopView: View {
    @ObservedObject private var gameSettings = GameSettings.shared
    
    var body: some View {
        OrientationView(requiredOrientation: .landscape) {
            ZStack {
                MainBackgroundView(imageName: .fon2)
                
                VStack {
                    HStack(alignment: .top) {
                        HStack {
                            // Current currency
                            AmountCounterView(badge: .coin, amount: gameSettings.currency)
                            
                            // Current hearts
                            AmountCounterView(badge: .heart, amount: gameSettings.hearts)
                        }
                        Spacer()
                        
                        Image(.frame4)
                            .resizable()
                            .frame(width: 150, height: 50)
                            .offset(x: -5)
                            .overlay {
                                Image(.shopText)
                                    .resizable()
                                    .scaledToFit()
                                    .offset(x: -5)
                                    .padding()
                            }
                        
                        Spacer()
                        CloseButtonView()
                    }
                    Spacer()
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        HStack(spacing: 30) {
                            ShopTileView(
                                coins: .coins4,
                                price: ._50000,
                                hearts: ._10,
                                priceAmount: GameConstants.heartsPrice10,
                                heartsAmount: 10,
                                isAffordable: gameSettings.canAfford(GameConstants.heartsPrice10)
                            ) {
                                purchaseHearts(count: 10, price: GameConstants.heartsPrice10)
                            }
                            
                            ShopTileView(
                                coins: .coins3,
                                price: ._25000,
                                hearts: ._7,
                                priceAmount: GameConstants.heartsPrice7,
                                heartsAmount: 7,
                                isAffordable: gameSettings.canAfford(GameConstants.heartsPrice7)
                            ) {
                                purchaseHearts(count: 7, price: GameConstants.heartsPrice7)
                            }
                        }
                        .padding(.top)
                        
                        HStack(spacing: 30) {
                            ShopTileView(
                                coins: .coins2,
                                price: ._15000,
                                hearts: ._5,
                                priceAmount: GameConstants.heartsPrice5,
                                heartsAmount: 5,
                                isAffordable: gameSettings.canAfford(GameConstants.heartsPrice5)
                            ) {
                                purchaseHearts(count: 5, price: GameConstants.heartsPrice5)
                            }
                            
                            ShopTileView(
                                coins: .coins1,
                                price: ._10000,
                                hearts: ._2,
                                priceAmount: GameConstants.heartsPrice2,
                                heartsAmount: 2,
                                isAffordable: gameSettings.canAfford(GameConstants.heartsPrice2)
                            ) {
                                purchaseHearts(count: 2, price: GameConstants.heartsPrice2)
                            }
                        }
                    }
                }
                .padding(.top)
                .padding(.horizontal)
            }
            .navigationBarHidden(true)
        }
    }
    
    // Function to handle heart purchases
    private func purchaseHearts(count: Int, price: Int) {
        if gameSettings.purchaseHearts(count: count, price: price) {
            // Optional: Add feedback (sound, animation, etc.) for successful purchase
        } else {
            // Optional: Add feedback for failed purchase
        }
    }
}

#Preview {
    ShopView()
}
