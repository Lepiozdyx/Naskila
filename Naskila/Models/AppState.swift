//
//  AppState.swift
//  Naskila
//
//  Created by Alex on 19.03.2025.
//

import Foundation

@MainActor
final class AppStateManager: ObservableObject {
    
    enum AppState {
        case loading
        case webView
        case mainMenu
    }
    
    @Published private(set) var appState: AppState = .loading
    let webManager: NetworkManager
    
    init(webManager: NetworkManager = NetworkManager()) {
        self.webManager = webManager
    }
    
    func stateCheck() {
        Task {
            if webManager.targetURL != nil {
                appState = .webView
                return
            }
            
            do {
                if try await webManager.checkInitialURL() {
                    appState = .webView
                } else {
                    appState = .mainMenu
                }
            } catch {
                appState = .mainMenu
            }
        }
    }
}
