//
//  ProfileViewModel.swift
//  Naskila
//
//  Created by Alex on 18.03.2025.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var selectedImageIndex: Int {
        didSet {
            saveSelectedImage()
        }
    }
    
    init() {
        self.selectedImageIndex = UserDefaults.standard.integer(forKey: "selectedProfileImageIndex")
        
        if !UserDefaults.standard.contains(key: "selectedProfileImageIndex") {
            self.selectedImageIndex = 0
        }
    }
    
    private func saveSelectedImage() {
        UserDefaults.standard.set(selectedImageIndex, forKey: "selectedProfileImageIndex")
    }
    
    var selectedImageResource: ImageResource {
        return getProfileImageResource(for: selectedImageIndex)
    }
    
    func getProfileImageResource(for index: Int) -> ImageResource {
        switch index {
        case 0: return .profileImage1
        case 1: return .profileImage2
        case 2: return .profileImage3
        case 3: return .profileImage4
        case 4: return .profileImage5
        case 5: return .profileImage6
        case 6: return .profileImage7
        default: return .profileImage1
        }
    }
}

extension UserDefaults {
    func contains(key: String) -> Bool {
        return object(forKey: key) != nil
    }
}
