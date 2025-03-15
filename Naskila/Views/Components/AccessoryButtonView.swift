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
    let action: () -> ()
    
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
    AccessoryButtonView(image: .paperbox, size: 50, action: {})
}
