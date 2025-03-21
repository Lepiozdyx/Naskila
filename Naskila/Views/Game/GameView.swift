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
    @State private var showNotEnoughHeartsAlert = false
    
    var body: some View {
        GeometryReader { geo in
            let height = geo.size.height
            let width = geo.size.width
            
            let buttonScale = min(width / 800, 2)
            
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
                                HStack(spacing: width * 0.15) {
                                    // MARK: Achievement button
                                    Button {
                                        viewModel.useAchievementButton()
                                    } label: {
                                        Image(.getBouquet)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: 50 * buttonScale)
                                            .overlay {
                                                if !viewModel.isAchievementButtonAvailable {
                                                    Image(.locker)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(maxWidth: 25 * buttonScale)
                                                        .transition(.scale)
                                                }
                                            }
                                    }
                                    .disabled(!viewModel.isAchievementButtonAvailable)
                                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: viewModel.isAchievementButtonAvailable)
                                    
                                    
                                    // MARK: Cleanup button
                                    Button {
                                        viewModel.clearWorkspace()
                                    } label: {
                                        Image(.cleanup)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: 50 * buttonScale)
                                    }
                                }
                                .padding(.trailing)
                                .padding(.bottom)
                            }
                        
                        HStack(alignment: .bottom) {
                            // MARK: Card button
                            VStack(spacing: 0) {
                                AccessoryButtonView(
                                    image: .card3,
                                    size: 40 * buttonScale,
                                    isActive: viewModel.isAccessoryActive(.card)
                                ) {
                                    viewModel.addAccessory(.card)
                                }
                                AccessoryButtonView(
                                    image: .card2,
                                    size: 40 * buttonScale,
                                    isActive: viewModel.isAccessoryActive(.card)
                                ) {
                                    viewModel.addAccessory(.card)
                                }
                                AccessoryButtonView(
                                    image: .card1,
                                    size: 40 * buttonScale,
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
                                    size: 60 * buttonScale,
                                    isActive: viewModel.isAccessoryActive(.wrapping)
                                ) {
                                    viewModel.addAccessory(.wrapping)
                                }
                                
                                AccessoryButtonView(
                                    image: .glitterbox,
                                    size: 60 * buttonScale,
                                    isActive: viewModel.isAccessoryActive(.glitter)
                                ) {
                                    viewModel.addAccessory(.glitter)
                                }
                                
                                AccessoryButtonView(
                                    image: .ribbonbox,
                                    size: 60 * buttonScale,
                                    isActive: viewModel.isAccessoryActive(.ribbon)
                                ) {
                                    viewModel.addAccessory(.ribbon)
                                }
                            }
                            .padding(.trailing)
                            
                            // MARK: First pair of vases
                            VStack(spacing: height * 0.05) {
                                // Red vase
                                VaseButtonView(
                                    size: 60 * buttonScale,
                                    color: .red,
                                    count: viewModel.vases[0].count,
                                    isDisabled: viewModel.vases[0].isDisabled,
                                    action: { viewModel.takeFlowerFromVase(color: .red) }
                                )
                                
                                // White vase
                                VaseButtonView(
                                    size: 60 * buttonScale,
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
                            .frame(width: 200 * buttonScale, height: 200 * buttonScale)
                            
                            Spacer()
                            
                            // MARK: Second pair of vases
                            VStack(spacing: height * 0.05) {
                                // Blue vase
                                VaseButtonView(
                                    size: 60 * buttonScale,
                                    color: .blue,
                                    count: viewModel.vases[2].count,
                                    isDisabled: viewModel.vases[2].isDisabled,
                                    action: { viewModel.takeFlowerFromVase(color: .blue) }
                                )
                                
                                // Pink vase
                                VaseButtonView(
                                    size: 60 * buttonScale,
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
                                .frame(width: 170 * buttonScale, height: 150 * buttonScale)
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
                // Check if player has enough hearts to start the game
                if !viewModel.settings.canStartGame() {
                    showNotEnoughHeartsAlert = true
                } else {
                    viewModel.startGame()
                }
            }
            .alert("Not enough hearts", isPresented: $showNotEnoughHeartsAlert) {
                Button("Back to menu", role: .cancel) {
                    dismiss()
                }
            } message: {
                Text("You are out of hearts. Purchase them from the in-game store to continue.")
            }
        }
    }
}

#Preview {
    GameView()
}
