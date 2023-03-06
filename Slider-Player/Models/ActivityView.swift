//
//  ActivityView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 19.02.2023.
//

import SwiftUI

class ActivityViewCustomActivity: UIActivity {
    
}

struct ActivityView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIActivityViewController
    public var activityItems: [Any]
    public var applicationActivities: [UIActivity]?
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let vc = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
//       code
    }
   
}






