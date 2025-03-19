//
//  ShopTileView.swift
//  Naskila
//
//  Created by Alex on 18.03.2025.
//

import SwiftUI

struct ShopTileView: View {
    let coins: ImageResource
    let price: ImageResource
    let hearts: ImageResource
    let priceAmount: Int
    let heartsAmount: Int
    let isAffordable: Bool
    let action: () -> Void
    
    var body: some View {
        Image(.frame6)
            .resizable()
            .frame(maxWidth: 300, maxHeight: 120)
            .overlay {
                HStack {
                    Image(.frame7)
                        .resizable()
                        .frame(maxWidth: 250, maxHeight: 110)
                        .overlay {
                            HStack {
                                Image(coins)
                                    .resizable()
                                    .scaledToFit()
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(.coin)
                                            .resizable()
                                            .scaledToFit()
                                        
                                        Image(price)
                                            .resizable()
                                            .scaledToFit()
                                    }
                                    
                                    HStack {
                                        Image(.heart)
                                            .resizable()
                                            .scaledToFit()
                                        
                                        Image(hearts)
                                            .resizable()
                                            .scaledToFit()
                                    }
                                }
                            }
                            .padding()
                        }
                    
                    Button {
                        action()
                    } label: {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(isAffordable ? .green : .gray)
                            .frame(width: 60, height: 50)
                            .shadow(color: .black, radius: 1, x: 0, y: 1)
                            .overlay {
                                Image(.buyText)
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                                    .opacity(isAffordable ? 1.0 : 0.5)
                            }
                    }
                    .buttonStyle(.plain)
                    .disabled(!isAffordable)
                }
                .padding()
            }
    }
}

extension ImageResource {
    var priceValue: Int {
        switch self {
        case ._10000: return GameConstants.heartsPrice2
        case ._15000: return GameConstants.heartsPrice5
        case ._25000: return GameConstants.heartsPrice7
        case ._50000: return GameConstants.heartsPrice10
        default: return 0
        }
    }
    
    var heartsValue: Int {
        switch self {
        case ._2: return 2
        case ._5: return 5
        case ._7: return 7
        case ._10: return 10
        default: return 0
        }
    }
}

#Preview {
    VStack {
        ShopTileView(
            coins: .coins1,
            price: ._25000,
            hearts: ._10,
            priceAmount: 25000,
            heartsAmount: 10,
            isAffordable: false,
            action: {}
        )
        ShopTileView(
            coins: .coins2,
            price: ._15000,
            hearts: ._5,
            priceAmount: 15000,
            heartsAmount: 5,
            isAffordable: true,
            action: {}
        )
    }
}
