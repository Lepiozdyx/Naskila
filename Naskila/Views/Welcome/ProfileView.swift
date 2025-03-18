//
//  ProfileView.swift
//  Naskila
//
//  Created by Alex on 18.03.2025.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            MainBackgroundView(imageName: .fon2)
            
            Image(.frame1)
                .resizable()
                .frame(maxWidth: 400, maxHeight: 400)
                .overlay(alignment: .topTrailing) {
                    CloseButtonView()
                }
                .padding()
            
            Image(.frame2)
                .resizable()
                .frame(maxWidth: 340, maxHeight: 280)
                .padding(.top)
                .overlay(alignment: .top) {
                    Image(.frame4)
                        .resizable()
                        .frame(width: 160, height: 50)
                        .offset(x: -5)
                        .overlay {
                            Image(.profile)
                                .resizable()
                                .scaledToFit()
                                .offset(x: -5)
                                .padding()
                        }
                }
                .overlay {
                    VStack(spacing: 10) {
                        Image(viewModel.selectedImageResource)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90)
                            .transition(.scale)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.red)
                            .frame(width: 310, height: 75)
                            .shadow(color: .black, radius: 2, x: 1, y: 1)
                            .overlay {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(0..<7, id: \.self) { index in
                                            Button {
                                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                                    viewModel.selectedImageIndex = index
                                                }
                                            } label: {
                                                Image(viewModel.getProfileImageResource(for: index))
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 65, height: 65)
                                                    .overlay(alignment: .bottomTrailing) {
                                                        if viewModel.selectedImageIndex == index {
                                                            Image(systemName: "checkmark")
                                                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                                                .foregroundStyle(.green)
                                                                .shadow(color: .black, radius: 1, x: 1, y: 1)
                                                        }
                                                    }
                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                    }
                }
                .overlay(alignment: .bottom) {
                    Button {
                        dismiss()
                    } label: {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(.green)
                            .frame(width: 100, height: 50)
                            .shadow(color: .black, radius: 1, x: 0, y: 1)
                            .overlay {
                                Image(.save)
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                            }
                    }
                }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel())
}
