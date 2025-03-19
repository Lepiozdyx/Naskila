//
//  Rating.swift
//  Naskila
//
//  Created by Alex on 19.03.2025.
//

import Foundation

import Foundation
import StoreKit

class RatingManager {
    static let shared = RatingManager()
    private let appId = "6743488231"
    
    private init() {}
    
    func requestReview() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
    
    func openAppStoreForRating() {
        let urlString = "https://apps.apple.com/app/id\(appId)?action=write-review"
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
