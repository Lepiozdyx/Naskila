//
//  WinView.swift
//  Naskila
//
//  Created by Alex on 16.03.2025.
//

import SwiftUI

struct WinView: View {
    let nextLevelAction: () -> Void
    let exitAction: () -> Void
    
    var body: some View {
        ZStack {
            Image(.fon2)
                .resizable()
                .ignoresSafeArea()
            
            Image(.frame1)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 350, maxHeight: 350)
                .overlay(alignment: .top) {
                    Image(.congratulationsOverlay)
                        .resizable()
                        .frame(maxWidth: 300, maxHeight: 170)
                }
                
            VStack {
                HStack {
                    ZStack {
                        Image(.puprleBlot)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70)
                        
                        Image(.shineCoins)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60)
                    }
                    
                    Image(._200)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                }
                
                HStack(spacing: 40) {
                    Button {
                        exitAction()
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
                        nextLevelAction()
                    } label: {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(.green)
                            .frame(width: 100, height: 50)
                            .shadow(color: .black, radius: 1, x: 0, y: 1)
                            .overlay {
                                Image(.nextText)
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                            }
                    }
                }
            }
            .padding(.top, 80)
        }
    }
}

#Preview {
    WinView(
        nextLevelAction: {},
        exitAction: {}
    )
}
