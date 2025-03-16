//
//  BouquetView.swift
//  Naskila
//
//  Created by Alex on 16.03.2025.
//

import SwiftUI

struct BouquetView: View {
    var body: some View {
        ZStack {
            Image(.paper1)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200)
            
            // Picked flowers
            HStack(spacing: -20) {
                ForEach(0..<4) { _ in
                    Image(.flowerRed1)
                        .resizable()
                        .frame(width: 45, height: 85)
                }
            }
        }
    }
}

#Preview {
    BouquetView()
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
                    Image(.flowerPink1)
                        .resizable()
                        .frame(width: 45, height: 85)
                    Image(.flowerRed2)
                        .resizable()
                        .frame(width: 60, height: 85)
                        .scaleEffect(x: -1)
                    Image(.flowerPink2)
                        .resizable()
                        .frame(width: 45, height: 85)
                        .offset(y: -25)
                    Image(.flowerPink2)
                        .resizable()
                        .frame(width: 45, height: 85)
                        .offset(y: -25)
                        .scaleEffect(x: -1)
                    Image(.flowerRed1)
                        .resizable()
                        .frame(width: 45, height: 85)
                        .offset(y: -15)
                    Image(.flowerBlue1)
                        .resizable()
                        .frame(width: 55, height: 85)
                    
                }
                
                HStack(spacing: -20) {
                    Image(.flowerWhite1)
                        .resizable()
                        .frame(width: 45, height: 85)
                    Image(.flowerWhite2)
                        .resizable()
                        .frame(width: 45, height: 85)
                        .offset(y: -35)
                    Image(.flowerBlue2)
                        .resizable()
                        .frame(width: 45, height: 85)
                        .offset(y: -25)
                    Image(.flowerBlue3)
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
