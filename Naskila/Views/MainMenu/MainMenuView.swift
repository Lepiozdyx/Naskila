//
//  MainMenuView.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import SwiftUI

struct MainMenuView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @ObservedObject private var gameSettings = GameSettings.shared
    @State private var showNotEnoughHeartsAlert = false
    @State private var navigateToGame = false
    @State private var navigateToShop = false
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        NavigationView {
            ZStack {
                MainBackgroundView(imageName: .fon)
                
                HStack {
                    Spacer()
                    
                    NavigationLink {
                        ProfileView(viewModel: viewModel)
                            .onAppear {
                                OrientationManager.shared.lockLandscape()
                            }
                    } label: {
                        Image(viewModel.selectedImageResource)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70)
                            .shadow(color: .black, radius: 2, x: 1, y: 2)
                    }
                }
                .padding(.trailing)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink {
                            ShopView()
                                .onAppear {
                                    OrientationManager.shared.lockLandscape()
                                }
                        } label: {
                            Image(.shop)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                        }
                    }
                }
                .padding(.trailing)
                .padding(.bottom)
                
                VStack {
                    HStack(alignment: .top) {
                        VStack {
                            // Display current currency
                            AmountCounterView(badge: .coin, amount: gameSettings.currency)
                            
                            // Display current hearts
                            AmountCounterView(badge: .heart, amount: gameSettings.hearts)
                        }
                        
                        Spacer()
                        
                        NavigationLink {
                            SettingsView()
                                .onAppear {
                                    OrientationManager.shared.lockLandscape()
                                }
                        } label: {
                            Image(.gear)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70)
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button {
                        // Check if player has enough hearts to play
                        if gameSettings.canStartGame() {
                            // Use state variable to trigger navigation
                            navigateToGame = true
                        } else {
                            // Show alert that player needs to get hearts
                            showNotEnoughHeartsAlert = true
                        }
                    } label: {
                        Image(.start)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 180)
                    }
                    
                    // Using NavigationLink with isActive binding
                    NavigationLink(
                        destination:
                            GameView()
                            .onAppear {
                                OrientationManager.shared.lockLandscape()
                            }
                        ,isActive: $navigateToGame
                    ) {
                        EmptyView()
                    }
                    
                    // Navigation link to shop
                    NavigationLink(
                        destination:
                            ShopView()
                            .onAppear {
                                OrientationManager.shared.lockLandscape()
                            },
                            isActive: $navigateToShop
                    ) {
                        EmptyView()
                    }
                }
                .alert("Not enough hearts", isPresented: $showNotEnoughHeartsAlert) {
                    Button("Shop") {
                        navigateToShop = true
                    }
                    Button("Back", role: .cancel) {}
                } message: {
                    Text("You are out of hearts. Purchase them from the in-game store to continue.")
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                if gameSettings.musicEnabled {
                    SoundManager.shared.playBackgroundMusic()
                }
            }
            .onChange(of: scenePhase) { newPhase in
                switch newPhase {
                case .active:
                    SoundManager.shared.handleAppForeground()
                case .background, .inactive:
                    SoundManager.shared.handleAppBackground()
                @unknown default:
                    break
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    MainMenuView()
}
