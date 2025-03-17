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
        Button {
            action()
        } label: {
            Image(.drybox)
                .resizable()
                .frame(width: 170, height: 150)
                .overlay {
                    HStack(spacing: -10) {
                        Image(.dryFlowerRed)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .scaleEffect(x: -1)
                        
                        Image(.dryFlowerBlue)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        
                        Image(.dryFlowerRed)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        
                        Image(.dryFlowerWhite)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        
                        Image(.dryFlowerBlue)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .scaleEffect(x: -1)
                        
                        Image(.dryFlowerWhite)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        
                        Image(.dryFlowerPink)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                    }
                }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    DryBoxButtonView(action: {})
}
