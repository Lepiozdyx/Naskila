//
//  MainMenuView.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        NavigationView {
            ZStack {
                MainBackgroundView(imageName: .fon)
                
                VStack {
                    Spacer()
                    
                    NavigationLink {
                        // GameView()
                    } label: {
                        Image(.start)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250)
                    }

                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    MainMenuView()
}
