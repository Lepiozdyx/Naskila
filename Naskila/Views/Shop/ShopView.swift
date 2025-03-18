//
//  ShopView.swift
//  Naskila
//
//  Created by Alex on 18.03.2025.
//

import SwiftUI

struct ShopView: View {
    var body: some View {
        ZStack {
            MainBackgroundView(imageName: .fon2)
            
            VStack {
                HStack(alignment: .top) {
                    HStack {
                        // viewModel.settings.currency
                        AmountCounterView(badge: .coin, amount: 123)
                        
                        // total lifes
                        AmountCounterView(badge: .heart, amount: 5)
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
                        ShopTileView(coins: .coins4, price: ._50000, hearts: ._10, action: {})
                        
                        ShopTileView(coins: .coins3, price: ._25000, hearts: ._7, action: {})
                    }
                    .padding(.top)
                    
                    HStack(spacing: 30) {
                        ShopTileView(coins: .coins2, price: ._15000, hearts: ._5, action: {})
                        
                        ShopTileView(coins: .coins1, price: ._10000, hearts: ._2, action: {})
                    }
                }
            }
            .padding(.top)
            .padding(.horizontal)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ShopView()
}
