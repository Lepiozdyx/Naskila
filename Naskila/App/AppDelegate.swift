//
//  AppDelegate.swift
//  Naskila
//
//  Created by Alex on 20.03.2025.
//

import UIKit
import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        OrientationHelper.orientationMask = .landscape
        OrientationHelper.isAutoRotationEnabled = false
        
        if #available(iOS 14.0, *) {
            
        } else {
            let contentView = CustomHostingController(rootView: ContentView())
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = contentView
            window?.makeKeyAndVisible()
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }
}

// Hosting Controller
class CustomHostingController<Content: View>: UIHostingController<Content> {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return OrientationHelper.orientationMask
    }

    override var shouldAutorotate: Bool {
        return OrientationHelper.isAutoRotationEnabled
    }
}

class OrientationHelper {
    public static var orientationMask: UIInterfaceOrientationMask = .landscapeLeft
    public static var isAutoRotationEnabled: Bool = false
}
