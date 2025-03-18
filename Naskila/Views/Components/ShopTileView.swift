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
    let action: () -> ()
    
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
                            .foregroundStyle(.green)
                            .frame(width: 60, height: 50)
                            .shadow(color: .black, radius: 1, x: 0, y: 1)
                            .overlay {
                                Image(.buyText)
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                            }
                    }
                    .buttonStyle(.plain)
                }
                .padding()
            }
    }
}

#Preview {
    VStack {
        ShopTileView(coins: .coins1, price: ._25000, hearts: ._10, action: {})
        ShopTileView(coins: .coins2, price: ._15000, hearts: ._5, action: {})
    }
}
