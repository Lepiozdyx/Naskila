//
//  LoadingView.swift
//  Naskila
//
//  Created by Alex on 18.03.2025.
//

import SwiftUI

struct LoadingView: View {
    @State private var loadingProgress: CGFloat = 0
    
    var body: some View {
        ZStack {
            MainBackgroundView(imageName: .fon3)
            
            VStack {
                Spacer()
                
                Image(.loading)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                
                Image(.yellowFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .background(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 6)
                            .foregroundStyle(.green)
                            .frame(width: loadingProgress * 295, height: 20)
                            .padding(.horizontal, 4)
                    }
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 0.8)) {
                loadingProgress = 1
            }
        }
    }
}

#Preview {
    LoadingView()
}
