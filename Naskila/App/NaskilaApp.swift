//
//  NaskilaApp.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import SwiftUI

@main
struct NaskilaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
