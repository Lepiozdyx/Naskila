//
//  TopBarView.swift
//  Naskila
//
//  Created by Alex on 15.03.2025.
//

import SwiftUI

struct TopBarView: View {
    let order: Order
    let customersServed: Int
    let totalCustomers: Int
    let currency: Int
    let pauseAction: () -> Void
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                // Order view
                OrderView(order: order)
                
                Spacer()
                
                // Customers counter
                AmountCounterView(
                    badge: .person,
                    amount: customersServed,
                    total: totalCustomers
                )
                
                // Currency counter
                AmountCounterView(badge: .coin, amount: currency)
                
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
    TopBarView(
        order: Order.random(),
        customersServed: 3,
        totalCustomers: 8,
        currency: 150,
        pauseAction: {}
    )
}
