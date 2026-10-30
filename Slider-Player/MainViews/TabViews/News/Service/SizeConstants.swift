//
//  SizeConstants.swift
//  NewsApp
//
//  Created by Алексей Езерский on 19.11.2024.
//

// Deprecated:
//struct SizeConstants {
//    static var avatarHeight: CGFloat {
//        UIScreen.main.bounds.height / 1.4
//    }
//    static var screenWidth: CGFloat {
//        UIScreen.main.bounds.width
//        
//    }
//}

import UIKit

enum SizeConstants {
    static var currentScreen: UIScreen? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first { $0.activationState == .foregroundActive }?
            .screen
    }

    static var avatarHeight: CGFloat {
        (currentScreen?.bounds.height ?? 0) / 1.4
    }

    static var screenWidth: CGFloat {
        currentScreen?.bounds.width ?? 0
    }
}


