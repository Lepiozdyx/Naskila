//
//  ContentView.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var root = AppStateManager()
    
    var body: some View {
        Group {
            switch root.appState {
            case .loading:
                LoadingView()
            case .webView:
                if let url = root.webManager.targetURL {
                    WebViewManager(url: url, webManager: root.webManager)
                } else {
                    WebViewManager(url: NetworkManager.initialURL, webManager: root.webManager)
                }
            case .mainMenu:
                MainMenuView()
            }
        }
        .onAppear {
            root.stateCheck()
        }
    }
}

#Preview {
    ContentView()
}
