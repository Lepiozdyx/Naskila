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
                        .onAppear {
                            OrientationManager.shared.unlockOrientation()
                        }
                } else {
                    WebViewManager(url: NetworkManager.initialURL, webManager: root.webManager)
                        .onAppear {
                            OrientationManager.shared.unlockOrientation()
                        }
                }
            case .mainMenu:
                MainMenuView()
                    .onAppear {
                        OrientationManager.shared.lockLandscape()
                    }
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
