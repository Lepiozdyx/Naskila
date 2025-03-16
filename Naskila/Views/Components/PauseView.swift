//
//  PauseView.swift
//  Naskila
//
//  Created by Alex on 16.03.2025.
//

import SwiftUI

struct PauseView: View {
    var body: some View {
        ZStack {
            Image(.fon2)
                .resizable()
                .ignoresSafeArea()
            
            Image(.frame1)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 350, maxHeight: 350)
                .overlay {
                    Image(.frame2)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 310, maxHeight: 300)
                        .padding(.top)
                        .overlay(alignment: .top) {
                            Image(.frame4)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 200, maxHeight: 150)
                                .offset(x: -5)
                                .overlay {
                                    Image(.pauseText)
                                        .resizable()
                                        .scaledToFit()
                                        .offset(x: -5)
                                        .padding(40)
                                }
                        }
                        .overlay(alignment: .topTrailing) {
                            CloseButtonView()
                        }
                }
            
            VStack(spacing: 20) {
                HStack(spacing: 40) {
                    SettingsControlButtonView(image: .musicicon, imageSize: 40, isOn: false, action: {})
                    
                    SettingsControlButtonView(image: .soundicon, imageSize: 35, isOn: true, action: {})
                }
                
                HStack(spacing: 40) {
                    Button {
                        // back to menu action
                    } label: {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(.red)
                            .frame(width: 100, height: 50)
                            .shadow(color: .black, radius: 1, x: 0, y: 1)
                            .overlay {
                                Image(.homeText)
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                            }
                    }
                    
                    Button {
                        // resume action
                    } label: {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(.green)
                            .frame(width: 100, height: 50)
                            .shadow(color: .black, radius: 1, x: 0, y: 1)
                            .overlay {
                                Image(.backText)
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                            }
                    }
                }
            }
            .padding(.top, 60)
        }
    }
}

#Preview {
    PauseView()
}
