//
//  SettingsView.swift
//  Naskila
//
//  Created by Alex on 18.03.2025.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject private var gameSettings = GameSettings.shared
    
    var body: some View {
        ZStack {
            MainBackgroundView(imageName: .fon2)
            
            Image(.frame1)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 350, maxHeight: 350)
                .overlay {
                    Image(.frame2)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 310, maxHeight: 300)
                        .overlay(alignment: .topTrailing) {
                            CloseButtonView()
                        }
                        .padding(.top)
                        .overlay(alignment: .top) {
                            Image(.frame4)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 200, maxHeight: 150)
                                .offset(x: -5)
                                .overlay {
                                    Image(.settingsText)
                                        .resizable()
                                        .scaledToFit()
                                        .offset(x: -5)
                                        .padding(30)
                                }
                        }
                }
            
            VStack(spacing: 20) {
                HStack(spacing: 40) {
                    SettingsControlButtonView(
                        image: .musicicon,
                        imageSize: 40,
                        isOn: true,
                        action: {}
                    )
                    
                    SettingsControlButtonView(
                        image: .soundicon,
                        imageSize: 35,
                        isOn: true,
                        action: {}
                    )
                }
                
                HStack {
                    Image(.like)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35)
                    
                    Button {
                        // rate app
                    } label: {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(.green)
                            .frame(width: 100, height: 50)
                            .shadow(color: .black, radius: 1, x: 0, y: 1)
                            .overlay {
                                Image(.rateusText)
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                            }
                    }
                    
                    Image(.like)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35)
                        .scaleEffect(x: -1)
                }
            }
            .padding(.top, 60)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    SettingsView()
}
