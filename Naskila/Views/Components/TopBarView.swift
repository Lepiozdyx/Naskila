//
//  TopBarView.swift
//  Naskila
//
//  Created by Alex on 15.03.2025.
//

import SwiftUI

struct TopBarView: View {
    let pauseAction: () -> ()
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                // OrderView()
                OrderView()
                
                Spacer()
                
                // Динамически обновляемый счетчик покупателей
                AmountCounterView(badge: .person, amount: 3)
                
                // Динамически обновляемый счетчик очков/валюты
                AmountCounterView(badge: .coin, amount: 150)
                
                Button {
                    pauseAction()
                } label: {
                    Image(.pause)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                }
                .padding(.leading)
            }
            Spacer()
            
        }
        .padding(.top)
        .padding(.horizontal)
    }
}

#Preview {
    TopBarView(pauseAction: {})
}
