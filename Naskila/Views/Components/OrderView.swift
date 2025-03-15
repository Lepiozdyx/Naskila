//
//  OrderView.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import SwiftUI

struct OrderView: View {
    var body: some View {
        Image(.orderFrame)
            .resizable()
            .scaledToFit()
            .frame(height: UIScreen.main.bounds.height * 0.45)
            .overlay {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 2) {
                        // Order
                        VStack(spacing: 2) {
                            ForEach(0..<4) { _ in
                                HStack(spacing: 2) {
                                    Text("1")
                                        .font(.system(size: 18, weight: .heavy, design: .rounded))
                                        .foregroundStyle(.red)
                                    
                                    Image(.flowerWhite1)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 40)
                                }
                            }
                        }
                        
                        HStack {
                            Text("+")
                                .font(.system(size: 14, weight: .heavy, design: .rounded))
                                .foregroundStyle(.black)
                            
                            Image(.paperbox)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                        }
                        
                        HStack {
                            Text("+")
                                .font(.system(size: 14, weight: .heavy, design: .rounded))
                                .foregroundStyle(.black)
                            
                            Image(.ribbonbox)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                        }
                        
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
                    .offset(x: -10)
                    .padding(.horizontal)
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
                OrderView()
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}
