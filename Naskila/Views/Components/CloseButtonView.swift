//
//  CloseButtonView.swift
//  Naskila
//
//  Created by Alex on 16.03.2025.
//

import SwiftUI

struct CloseButtonView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var gameSettings = GameSettings.shared
    
    var body: some View {
        Button {
            if gameSettings.soundEnabled {
                SoundManager.shared.playSound()
            }
            dismiss()
        } label: {
            Image(.closeButton)
                .resizable()
                .scaledToFit()
                .frame(width: 50)
        }
    }
}

#Preview {
    CloseButtonView()
}
