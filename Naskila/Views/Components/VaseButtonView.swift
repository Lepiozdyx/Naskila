//
//  VaseButtonView.swift
//  Naskila
//
//  Created by Alex on 15.03.2025.
//

import SwiftUI

struct VaseButtonView: View {
    let size: CGFloat
    let color: FlowerColor
    let count: Int
    let isDisabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(.vase)
                .resizable()
                .scaledToFit()
                .frame(width: size)
                .background {
                    // Display flowers in the vase
                    HStack(spacing: -25) {
                        ForEach(0..<count, id: \.self) { _ in
                            Image(color.displayName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35)
                                .offset(y: -25)
                        }
                    }
                    .offset(x: 5)
                }
        }
        .overlay(alignment: .bottomTrailing) {
            if isDisabled {
                TimerView()
            }
        }
        .buttonStyle(.plain)
        .disabled(isDisabled || count == 0)
    }
}

#Preview {
    HStack {
        // Active vase with flowers
        VaseButtonView(
            size: 60,
            color: .red,
            count: 4,
            isDisabled: false,
            action: {}
        )
        
        VaseButtonView(
            size: 60,
            color: .pink,
            count: 4,
            isDisabled: false,
            action: {}
        )
        
        VaseButtonView(
            size: 60,
            color: .white,
            count: 4,
            isDisabled: false,
            action: {}
        )
        
        // Disabled vase with flowers
        VaseButtonView(
            size: 60,
            color: .blue,
            count: 4,
            isDisabled: true,
            action: {}
        )
        
        // Empty vase
        VaseButtonView(
            size: 60,
            color: .pink,
            count: 0,
            isDisabled: false,
            action: {}
        )
    }
}
