//
//  VaseButtonView.swift
//  Naskila
//
//  Created by Alex on 15.03.2025.
//

import SwiftUI

struct VaseButtonView: View {
    let size: CGFloat
    let action: () -> ()
    
    var body: some View {
        Button {
            // pick flower to bouquet if !isDisabled
            action()
        } label: {
            Image(.vase)
                .resizable()
                .scaledToFit()
                .frame(width: size)
                .overlay(alignment: .topTrailing) {
                    // if isDisabled show timer
                    TimerView()
                }
                .background {
                    // VaseState.flowers
                    // 1-4 red flowers
                    HStack(spacing: -25) {
                        ForEach(0..<4) { _ in
                            Image(.flowerRed1)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35)
                                .offset(y: -25)
                        }
                    }
                    .offset(x: 5)
                }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VaseButtonView(size: 60, action: {})
}
