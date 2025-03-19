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
        GeometryReader { geo in
            let adaptiveSize = min(geo.size.width, geo.size.height)
            
            Button {
                action()
            } label: {
                Image(.vase)
                    .resizable()
                    .scaledToFit()
                    .frame(width: adaptiveSize)
                    .background {
                        // Display flowers in the vase
                        HStack(spacing: -adaptiveSize * 0.45) {
                            ForEach(0..<count, id: \.self) { _ in
                                Image(color.displayName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: adaptiveSize * 0.55)
                                    .offset(y: -adaptiveSize * 0.4)
                            }
                        }
                        .offset(x: -adaptiveSize * 0.02)
                    }
            }
            .overlay(alignment: .bottomTrailing) {
                if isDisabled {
                    TimerView()
                        .frame(width: adaptiveSize * 0.4)
                }
            }
            .buttonStyle(.plain)
            .disabled(isDisabled || count == 0)
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
        }
        .aspectRatio(1, contentMode: .fit)
        .frame(maxWidth: size, maxHeight: size)
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
