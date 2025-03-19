//
//  NaskilaApp.swift
//  Naskila
//
//  Created by Alex on 13.03.2025.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown, .landscape]
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        OrientationManager.shared.updateOrientation()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        OrientationManager.shared.updateOrientation()
    }
}

@main
struct NaskilaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .onAppear {
                    UIDevice.current.beginGeneratingDeviceOrientationNotifications()
                }
        }
    }
}
