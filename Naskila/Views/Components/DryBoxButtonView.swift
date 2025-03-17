//
//  DryBoxButtonView.swift
//  Naskila
//
//  Created by Alex on 15.03.2025.
//

import SwiftUI

enum DryBoxColorType {
    case redWhite
    case bluePink
}

struct DryBoxButtonView: View {
    var colorType: DryBoxColorType = .redWhite
    let action: () -> Void
    
    private var flowerImages: [ImageResource] {
        switch colorType {
        case .redWhite:
            return [.dryFlowerRed1, .dryFlowerWhite1, .dryFlowerRed1, .dryFlowerWhite1]
        case .bluePink:
            return [.dryFlowerBlue1, .dryFlowerPink1, .dryFlowerBlue1, .dryFlowerPink1]
        }
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(.drybox)
                .resizable()
                .frame(width: 170, height: 90)
                .overlay {
                    HStack(spacing: 2) {
                        ForEach(0..<flowerImages.count, id: \.self) { index in
                            Image(flowerImages[index])
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
