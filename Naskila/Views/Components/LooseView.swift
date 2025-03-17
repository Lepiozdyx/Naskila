//
//  LooseView.swift
//  Naskila
//
//  Created by Alex on 16.03.2025.
//

import SwiftUI

struct LooseView: View {
    let restartAction: () -> Void
    let exitAction: () -> Void
    
    var body: some View {
        ZStack {
            Image(.fon2)
                .resizable()
                .ignoresSafeArea()
            
            Image(.looseFrame)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 350, maxHeight: 350)
            
            VStack(spacing: 10) {
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
                    restartAction()
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(.green)
                        .frame(width: 100, height: 50)
                        .shadow(color: .black, radius: 1, x: 0, y: 1)
                        .overlay {
                            Image(.resetText)
                                .resizable()
                                .scaledToFit()
                                .padding()
                        }
                }
            }
            .padding(.trailing)
            .padding(.top, 100)
        }
    }
}

#Preview {
    LooseView(
        restartAction: {},
        exitAction: {}
    )
}
