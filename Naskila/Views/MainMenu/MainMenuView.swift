//
//  MainMenuView.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import SwiftUI

struct MainMenuView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                MainBackgroundView(imageName: .fon)
                
                HStack {
                    Spacer()
                    
                    NavigationLink {
                        ProfileView(viewModel: viewModel)
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
                            // viewModel.settings.currency
                            AmountCounterView(badge: .coin, amount: 123)
                            
                            // total lifes
                            AmountCounterView(badge: .heart, amount: 5)
                        }
                        
                        Spacer()
                        
                        NavigationLink {
                             SettingsView()
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
                    
                    NavigationLink {
                         GameView()
                    } label: {
                        Image(.start)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 180)
                    }

                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    MainMenuView()
}
