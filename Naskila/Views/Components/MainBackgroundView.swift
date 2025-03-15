//
//  MainBackgroundView.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import SwiftUI

struct MainBackgroundView: View {
    let imageName: ImageResource
    
    var body: some View {
        Image(imageName)
            .resizable()
            .ignoresSafeArea()
    }
}

#Preview {
    MainBackgroundView(imageName: .fon)
}
