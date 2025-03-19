//
//  DryBoxButtonView.swift
//  Naskila
//
//  Created by Alex on 15.03.2025.
//

import SwiftUI

struct DryBoxButtonView: View {
    let action: () -> Void
    
    var body: some View {
        GeometryReader { geo in
            let boxWidth = geo.size.width
            let boxHeight = geo.size.height
            let flowerSize = boxWidth * 0.2
            
            Button {
                action()
            } label: {
                Image(.drybox)
                    .resizable()
                    .frame(maxWidth: boxWidth, maxHeight: boxHeight)
                    .overlay {
                        HStack(spacing: -flowerSize * 0.3) {
                            Image(.dryFlowerRed)
                                .resizable()
                                .scaledToFit()
                                .frame(width: flowerSize)
                                .scaleEffect(x: -1)
                            
                            Image(.dryFlowerBlue)
                                .resizable()
                                .scaledToFit()
                                .frame(width: flowerSize)
                            
                            Image(.dryFlowerRed)
                                .resizable()
                                .scaledToFit()
                                .frame(width: flowerSize)
                            
                            Image(.dryFlowerWhite)
                                .resizable()
                                .scaledToFit()
                                .frame(width: flowerSize)
                            
                            Image(.dryFlowerBlue)
                                .resizable()
                                .scaledToFit()
                                .frame(width: flowerSize)
                                .scaleEffect(x: -1)
                            
                            Image(.dryFlowerWhite)
                                .resizable()
                                .scaledToFit()
                                .frame(width: flowerSize)
                            
                            Image(.dryFlowerPink)
                                .resizable()
                                .scaledToFit()
                                .frame(width: flowerSize)
                        }
                    }
            }
            .buttonStyle(.plain)
            .position(x: boxWidth / 2, y: boxHeight / 2)
        }
        .aspectRatio(170/150, contentMode: .fit)
        .frame(maxWidth: 170, maxHeight: 150)
    }
}

#Preview {
    DryBoxButtonView(action: {})
}
