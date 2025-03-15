//
//  AmountCounterView.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import SwiftUI

struct AmountCounterView: View {
    let badge: ImageResource
    let amount: Int
    
    var body: some View {
        Image(.frame)
            .resizable()
            .scaledToFit()
            .frame(width: 150)
            .overlay(alignment: .trailing) {
                Image(badge)
                    .resizable()
                    .scaledToFit()
            }
            .overlay {
                Text("\(amount)")
                    .font(.system(size: 18, weight: .heavy, design: .rounded))
                    .offset(x: -10)
            }
    }
}

#Preview {
    AmountCounterView(badge: .coin, amount: 150)
}
