//
//  SettingsControlButtonView.swift
//  Naskila
//
//  Created by Alex on 16.03.2025.
//

import SwiftUI

struct SettingsControlButtonView: View {
    let image: ImageResource
    let imageSize: CGFloat
    var isOn: Bool
    let action: ()-> ()
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: imageSize)
                .overlay {
                    if !isOn {
                        Rectangle()
                            .foregroundStyle(.red)
                            .frame(width: 4, height: 60)
                            .rotationEffect(.degrees(45))
                    }
                }
            
            Button {
                withAnimation {
                    action()
                }
            } label: {
                Image(.frame5)
                    .resizable()
                    .frame(width: 80, height: 40)
                    .overlay(alignment: isOn ? .leading : .trailing) {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(.yellow)
                            .frame(width: 45, height: 35)
                            .overlay {
                                Image(isOn ? .onText : .offText)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(6)
                            }
                            .padding(.horizontal, 2)
                    }
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    SettingsControlButtonView(image: .musicicon, imageSize: 40, isOn: true, action: {})
}
