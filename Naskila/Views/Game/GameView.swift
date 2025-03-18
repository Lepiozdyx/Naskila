//
//  GameView.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        GeometryReader { geo in
            let height = geo.size.height
            
            ZStack {
                MainBackgroundView(imageName: .fon1)
                
                // MARK: Customers
                CustomerView(customer: viewModel.currentCustomer.imageResource)
                    .offset(x: viewModel.customerTransition == .none ? 0 :
                                viewModel.customerTransition == .entering ? viewModel.customerTransition.offset :
                                viewModel.customerTransition.offset)
                    .animation(viewModel.customerTransition.animation, value: viewModel.customerTransition)
                
                // MARK: TopBar
                TopBarView(
                    order: viewModel.currentOrder,
                    customersServed: viewModel.customersServed,
                    totalCustomers: GameConstants.customersPerLevel,
                    currency: viewModel.settings.currency,
                    pauseAction: { viewModel.pauseGame() }
                )
                
                // MARK: Workspace
                VStack {
                    Spacer()
                    
                    ZStack {
                        Image(.workspace)
                            .resizable()
                            .frame(height: height * 0.6)
                            .overlay(alignment: .bottom) {
                                HStack(spacing: 150) {
                                    
                                    // MARK: Achievement button
                                    Button {
                                        // get bouquet achievement
                                    } label: {
                                        Image(.getBouquet)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50)
                                            .overlay {
                                                Image(.locker)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 25)
                                            }
                                    }
                                    
                                    // MARK: Cleanup button
                                    Button {
                                        viewModel.clearWorkspace()
                                    } label: {
                                        Image(.cleanup)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50)
                                    }
                                }
                                .padding(.trailing)
                                .padding(.bottom, 8)
                            }
                        
                        HStack(alignment: .bottom) {
                            // MARK: Card button
                            VStack(spacing: 0) {
                                AccessoryButtonView(
                                    image: .card3,
                                    size: 40,
                                    isActive: viewModel.isAccessoryActive(.card)
                                ) {
                                    viewModel.addAccessory(.card)
                                }
                                AccessoryButtonView(
                                    image: .card2,
                                    size: 40,
                                    isActive: viewModel.isAccessoryActive(.card)
                                ) {
                                    viewModel.addAccessory(.card)
                                }
                                AccessoryButtonView(
                                    image: .card1,
                                    size: 40,
                                    isActive: viewModel.isAccessoryActive(.card)
                                ) {
                                    viewModel.addAccessory(.card)
                                }
                            }
                            .padding(.trailing)
                            
                            // MARK: Accessories buttons
                            VStack(spacing: 0) {
                                AccessoryButtonView(
                                    image: .paperbox,
                                    size: 60,
                                    isActive: viewModel.isAccessoryActive(.wrapping)
                                ) {
                                    viewModel.addAccessory(.wrapping)
                                }
                                
                                AccessoryButtonView(
                                    image: .glitterbox,
                                    size: 60,
                                    isActive: viewModel.isAccessoryActive(.glitter)
                                ) {
                                    viewModel.addAccessory(.glitter)
                                }
                                
                                AccessoryButtonView(
                                    image: .ribbonbox,
                                    size: 60,
                                    isActive: viewModel.isAccessoryActive(.ribbon)
                                ) {
                                    viewModel.addAccessory(.ribbon)
                                }
                            }
                            .padding(.trailing)
                            
                            // MARK: First pair of vases
                            VStack(spacing: 30) {
                                // Red vase
                                VaseButtonView(
                                    size: 60,
                                    color: .red,
                                    count: viewModel.vases[0].count,
                                    isDisabled: viewModel.vases[0].isDisabled,
                                    action: { viewModel.takeFlowerFromVase(color: .red) }
                                )
                                
                                // White vase
                                VaseButtonView(
                                    size: 60,
                                    color: .white,
                                    count: viewModel.vases[1].count,
                                    isDisabled: viewModel.vases[1].isDisabled,
                                    action: { viewModel.takeFlowerFromVase(color: .white) }
                                )
                            }
                            
                            Spacer()
                            
                            // MARK: Bouquet view
                            BouquetView(
                                bouquet: viewModel.currentBouquet,
                                packagingState: viewModel.bouquetPackagingState
                            )
                            .frame(width: 200, height: 200)
                            
                            Spacer()
                            
                            // MARK: Second pair of vases
                            VStack(spacing: 30) {
                                // Blue vase
                                VaseButtonView(
                                    size: 60,
                                    color: .blue,
                                    count: viewModel.vases[2].count,
                                    isDisabled: viewModel.vases[2].isDisabled,
                                    action: { viewModel.takeFlowerFromVase(color: .blue) }
                                )
                                
                                // Pink vase
                                VaseButtonView(
                                    size: 60,
                                    color: .pink,
                                    count: viewModel.vases[3].count,
                                    isDisabled: viewModel.vases[3].isDisabled,
                                    action: { viewModel.takeFlowerFromVase(color: .pink) }
                                )
                            }
                            
                            // MARK: Add Dry flowers to vases button
                            VStack(spacing: 4) {
                                DryBoxButtonView(action: {
                                    viewModel.addFlowerToVase(color: .red)
                                    viewModel.addFlowerToVase(color: .white)
                                    viewModel.addFlowerToVase(color: .blue)
                                    viewModel.addFlowerToVase(color: .pink)
                                })
                            }
                        }
                        .padding(.horizontal, 60)
                    }
                }
                .ignoresSafeArea()
                
                // MARK: Overlay views
                if viewModel.gameOverlay != .none {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                    
                    switch viewModel.gameOverlay {
                    case .pause:
                        PauseView(
                            soundEnabled: viewModel.settings.soundEnabled,
                            musicEnabled: viewModel.settings.musicEnabled,
                            toggleSound: { viewModel.toggleSound() },
                            toggleMusic: { viewModel.toggleMusic() },
                            resumeAction: { viewModel.resumeGame() },
                            exitAction: { dismiss() }
                        )
                    case .victory:
                        WinView(
                            nextLevelAction: { viewModel.startGame() },
                            exitAction: { dismiss() }
                        )
                    case .defeat:
                        LooseView(
                            restartAction: { viewModel.startGame() },
                            exitAction: { dismiss() }
                        )
                    case .none:
                        EmptyView()
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                viewModel.startGame()
            }
        }
    }
}

#Preview {
    GameView()
}
