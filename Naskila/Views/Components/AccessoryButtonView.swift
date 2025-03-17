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
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: size)
        }
        .buttonStyle(.plain)
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
