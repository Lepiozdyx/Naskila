//
//  CustomerView.swift
//  Naskila
//
//  Created by Alex on 15.03.2025.
//

import SwiftUI

struct CustomerView: View {
    let customer: ImageResource
    
    var body: some View {
        HStack {
            Spacer()
            Image(customer)
                .resizable()
                .scaledToFit()
            Spacer()
            Spacer()
            Spacer()
        }
        .padding(.top)
    }
}

#Preview {
    CustomerView(customer: .customer1)
}
