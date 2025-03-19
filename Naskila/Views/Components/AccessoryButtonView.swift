//
//  ItemButtonView.swift
//  Naskila
//
//  Created by Alex on 15.03.2025.
//

import SwiftUI

struct AccessoryButtonView: View {
    let image: ImageResource
    let size: CGFloat
    let isActive: Bool
    let action: () -> Void
    
    @ObservedObject private var gameSettings = GameSettings.shared
    
    var body: some View {
        Button {
            gameSettings.playSound()
            action()
        } label: {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: size)
        }
        .buttonStyle(.plain)
        .disabled(!isActive)
    }
}

#Preview {
    HStack {
        // Active button
        AccessoryButtonView(
            image: .paperbox,
            size: 60,
            isActive: true
        ) {}
        
        // Inactive button
        AccessoryButtonView(
            image: .ribbonbox,
            size: 60,
            isActive: false
        ) {}
    }
}
