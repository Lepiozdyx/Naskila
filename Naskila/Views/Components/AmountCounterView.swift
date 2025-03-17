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
    var total: Int? = nil
    
    var displayedText: String {
        if let total = total {
            return "\(amount)/\(total)"
        } else {
            return "\(amount)"
        }
    }
    
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
                Text(displayedText)
                    .font(.system(size: 18, weight: .heavy, design: .rounded))
                    .offset(x: -10)
            }
    }
}

#Preview {
    AmountCounterView(badge: .coin, amount: 150)
}
