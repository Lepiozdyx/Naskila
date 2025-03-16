//
//  CloseButtonView.swift
//  Naskila
//
//  Created by Alex on 16.03.2025.
//

import SwiftUI

struct CloseButtonView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button {
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
