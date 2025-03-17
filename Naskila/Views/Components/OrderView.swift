//
//  OrderView.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import SwiftUI

struct OrderView: View {
    let order: Order
    
    var body: some View {
        Image(.orderFrame)
            .resizable()
            .scaledToFit()
            .frame(height: UIScreen.main.bounds.height * 0.45)
            .overlay {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 2) {
                        // Show flowers needed
                        VStack(spacing: 2) {
                            // Red flowers
                            if order.redFlowers > 0 {
                                HStack(alignment: .bottom, spacing: 2) {
                                    Text("\(order.redFlowers)")
                                        .font(.system(size: 18, weight: .heavy, design: .rounded))
                                        .foregroundStyle(.red)
                                    
                                    Image(.flowerRed)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 35)
                                }
                            }
                            
                            // White flowers
                            if order.whiteFlowers > 0 {
                                HStack(alignment: .bottom, spacing: 2) {
                                    Text("\(order.whiteFlowers)")
                                        .font(.system(size: 18, weight: .heavy, design: .rounded))
                                        .foregroundStyle(.white)
                                        .shadow(color: .black, radius: 0.7)
                                    
                                    Image(.flowerWhite)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 35)
                                }
                            }
                            
                            // Blue flowers
                            if order.blueFlowers > 0 {
                                HStack(alignment: .bottom, spacing: 2) {
                                    Text("\(order.blueFlowers)")
                                        .font(.system(size: 18, weight: .heavy, design: .rounded))
                                        .foregroundStyle(.blue)
                                    
                                    Image(.flowerBlue)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 35)
                                }
                            }
                            
                            // Pink flowers
                            if order.pinkFlowers > 0 {
                                HStack(alignment: .bottom, spacing: 2) {
                                    Text("\(order.pinkFlowers)")
                                        .font(.system(size: 18, weight: .heavy, design: .rounded))
                                        .foregroundStyle(.pink)
                                    
                                    Image(.flowerPink)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 35)
                                }
                            }
                        }
                        
                        // Show accessories needed
                        if order.needWrapping {
                            HStack {
                                Text("+")
                                    .font(.system(size: 14, weight: .heavy, design: .rounded))
                                    .foregroundStyle(.black)
                                
                                Image(.paperbox)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                            }
                        }
                        
                        if order.needRibbon {
                            HStack {
                                Text("+")
                                    .font(.system(size: 14, weight: .heavy, design: .rounded))
                                    .foregroundStyle(.black)
                                
                                Image(.ribbonbox)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                            }
                        }
                        
                        if order.needGlitter {
                            HStack {
                                Text("+")
                                    .font(.system(size: 14, weight: .heavy, design: .rounded))
                                    .foregroundStyle(.black)
                                
                                Image(.glitterbox)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                            }
                        }
                        
                        if order.needCard {
                            HStack {
                                Text("+")
                                    .font(.system(size: 14, weight: .heavy, design: .rounded))
                                    .foregroundStyle(.black)
                                
                                Image(.card1)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                            }
                        }
                    }
                    .offset(x: -10)
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
                .padding(4)
            }
    }
}

#Preview {
    ZStack {
        MainBackgroundView(imageName: .fon1)
        VStack {
            HStack {
                OrderView(
                    order: Order(
                        redFlowers: 4,
                        whiteFlowers: 3,
                        blueFlowers: 2,
                        pinkFlowers: 1,
                        needWrapping: true,
                        needRibbon: true,
                        needGlitter: true,
                        needCard: true
                    )
                )
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}
