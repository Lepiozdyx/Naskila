//
//  DryBoxButtonView.swift
//  Naskila
//
//  Created by Alex on 15.03.2025.
//

import SwiftUI

struct DryBoxButtonView: View {
    let action: () -> ()
    
    var body: some View {
        Button {
            // pick dry flower and place to the vase
            action()
        } label: {
            Image(.drybox)
                .resizable()
                .frame(width: 170, height: 90)
                .overlay {
                    HStack(spacing: 2) {
                        // red and pink dry flower images
                        ForEach(0..<4) { _ in
                            Image(.dryFlowerRed1)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25)
                        }
                    }
                    
                }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    DryBoxButtonView(action: {})
}
