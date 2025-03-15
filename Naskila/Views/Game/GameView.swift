//
//  GameView.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import SwiftUI

struct GameView: View {
    var body: some View {
        GeometryReader { geo in
            let height = geo.size.height
            let _ = geo.size.width
            
            ZStack {
                MainBackgroundView(imageName: .fon1)
                
                // MARK: Customers
                CustomerView(customer: .customer1)
                
                // MARK: TopBar
                TopBarView(pauseAction: {})
                
                // MARK: Workspace
                VStack {
                    Spacer()
                    
                    ZStack {
                        Image(.workspace)
                            .resizable()
                            .frame(height: height * 0.6)
                        
                        HStack(alignment: .bottom) {
                            // Cards buttons
                            VStack(spacing: 0) {
                                ForEach(0..<3) { _ in
                                    AccessoryButtonView(image: .card1, size: 40) {}
                                }
                            }
                            .padding(.trailing)
                            
                            // Accessories buttons
                            VStack(spacing: 0) {
                                AccessoryButtonView(image: .paperbox, size: 60) {}
                                
                                AccessoryButtonView(image: .glitterbox, size: 60) {}
                                
                                AccessoryButtonView(image: .ribbonbox, size: 60) {}
                            }
                            .padding(.trailing)
                            
                            // Vases buttons
                            VStack(spacing: 30) {
                                // Vase 1
                                VaseButtonView(size: 60, action: {})
                                
                                // Vase 2
                                VaseButtonView(size: 60, action: {})
                            }
                            
                            Spacer()
                            // Bouquet
                            BouquetView()
                            
                            Spacer()
                            
                            // Vases buttons
                            VStack(spacing: 30) {
                                // Vase 3
                                VaseButtonView(size: 60, action: {})
                                
                                // Vase 4
                                VaseButtonView(size: 60, action: {})
                            }
                            
                            // Dry flowers buttons
                            VStack(spacing: 4) {
                                DryBoxButtonView(action: {})
                                
                                DryBoxButtonView(action: {})
                            }
                        }
                        .padding(.horizontal, 60)
                    }
                }
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    GameView()
}

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
                        .frame(width: 50, height: 85)
                }
            }
        }
    }
}
