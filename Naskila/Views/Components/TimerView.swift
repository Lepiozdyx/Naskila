//
//  TimerView.swift
//  Naskila
//
//  Created by Alex on 15.03.2025.
//

import SwiftUI

struct TimerView: View {
    var body: some View {
        Image(.timericon)
            .resizable()
            .scaledToFit()
            .frame(width: 25)
            .overlay {
                Rectangle()
                    .frame(width: 2, height: 10)
                    .rotationEffect(Angle(degrees: -45))
                    .foregroundStyle(.red)
                    .offset(x: -2, y: 1)
            }
    }
}

#Preview {
    TimerView()
}
