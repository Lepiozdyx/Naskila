//
//  Orientation.swift
//  Naskila
//
//  Created by Alex on 19.03.2025.
//

import SwiftUI
import Combine

class OrientationManager: ObservableObject {
    
    static let shared = OrientationManager()
    
    @Published var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @Published var isLandscape: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        
        NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
            .debounce(for: .milliseconds(50), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.updateOrientation()
            }
            .store(in: &cancellables)
            
        updateOrientation()
    }
    
    deinit {
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }
    
    func updateOrientation() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
        if let interfaceOrientation = windowScene?.interfaceOrientation {
            isLandscape = interfaceOrientation.isLandscape

            switch interfaceOrientation {
            case .landscapeLeft:
                orientation = .landscapeLeft
            case .landscapeRight:
                orientation = .landscapeRight
            case .portrait:
                orientation = .portrait
            case .portraitUpsideDown:
                orientation = .portraitUpsideDown
            default:
                orientation = UIDevice.current.orientation
            }
        } else {
            let deviceOrientation = UIDevice.current.orientation
            
            if deviceOrientation.isValidInterfaceOrientation {
                orientation = deviceOrientation
                isLandscape = deviceOrientation.isLandscape
            } else {
                let activeWindowScene = UIApplication.shared.connectedScenes
                    .filter { $0.activationState == .foregroundActive }
                    .first as? UIWindowScene
                
                let statusBarOrientation = activeWindowScene?.interfaceOrientation
                isLandscape = statusBarOrientation?.isLandscape ?? false
            }
        }
        
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
}

struct OrientationView<Content: View>: View {
    @ObservedObject private var orientationManager = OrientationManager.shared
    
    let requiredOrientation: UIInterfaceOrientationMask
    let content: Content
    let restrictionMessage: String
    
    init(
        requiredOrientation: UIInterfaceOrientationMask,
        restrictionMessage: String = "Rotate the device",
        @ViewBuilder content: () -> Content
    ) {
        self.requiredOrientation = requiredOrientation
        self.restrictionMessage = restrictionMessage
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            if isOrientationValid {
                content
            } else {
                ZStack {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    
                    Image(.frame2)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 350)
                        .overlay {
                            VStack(spacing: 10) {
                                Text("Flip the device")
                                    .font(.system(size: 24, weight: .bold, design: .rounded))
                                    .foregroundColor(.black)
                                
                                Text("Flip the device to the landscape orientation")
                                    .font(.system(size: 20, weight: .regular, design: .default))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                
                                Image(systemName: "rectangle.portrait.rotate")
                                    .font(.system(size: 30))
                                    .foregroundColor(.red)
                            }
                            .padding()
                        }
                        
                }
            }
        }
        .onAppear {
            orientationManager.updateOrientation()
        }
        .onChange(of: orientationManager.isLandscape) { _ in
            orientationManager.updateOrientation()
        }
    }
    
    private var isOrientationValid: Bool {
        switch requiredOrientation {
        case .landscape, .landscapeLeft, .landscapeRight:
            return orientationManager.isLandscape
        case .portrait, .portraitUpsideDown:
            return !orientationManager.isLandscape
        default:
            return true
        }
    }
}

extension UIInterfaceOrientationMask {
    static var landscape: UIInterfaceOrientationMask { .landscapeLeft.union(.landscapeRight) }
}
