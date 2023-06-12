//
//  RewindingTextTicker.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 06.11.2024.
//
// Use for running line

/*
import SwiftUI

struct RewindingTextTicker: View {
    
    let textKey: String
    let viewWidth: CGFloat
    let beginEndDelaySecs: TimeInterval
    
    init(
        textKey: String,
        viewWidth: CGFloat,
        beginEndDelaySecs: TimeInterval = 1.0 //default: 1.0
    ) {
        self.textKey = textKey
        self.viewWidth = viewWidth
        self.beginEndDelaySecs = beginEndDelaySecs
    }
    
    let pixelsPerSec = 50 //default: 100
    @State private var progress = CGFloat.zero
    
    private func duration(width: CGFloat) -> TimeInterval {
        (TimeInterval(max(width, 0)) / TimeInterval(pixelsPerSec)) + beginEndDelaySecs
    }
    
    private func endWaitFraction(textWidth: CGFloat) -> CGFloat {
        let totalDuration = duration(width: textWidth - viewWidth)
        return totalDuration > 0 ? beginEndDelaySecs / totalDuration : 0
    }
    
    var body: some View {
        
        // Display the full text on one line.
        // This establishes the width that is needed
        Text(LocalizedStringKey(textKey))
            .lineLimit(1)
            .fixedSize(horizontal: true, vertical: true)
        
        // Perform the animation in an overlay
            .overlay(
                GeometryReader { proxy in
                    Text(LocalizedStringKey(textKey))
                        .modifier(
                            OffsetModifier(
                                maxOffset: viewWidth - proxy.size.width,
                                endWaitFraction: endWaitFraction(textWidth: proxy.size.width),
                                progress: progress
                            )
                        )
                        .animation(
                            .linear(duration: duration(width: proxy.size.width - viewWidth))
                            .delay(beginEndDelaySecs)
                            .repeatForever(autoreverses: false),
                            value: progress
                        )
                    // Mask out the base view
                        .background(Color(UIColor.systemBackground))
                }
            )
            .onAppear { progress = 1.0 } //Default: 1.0
    }
}
*/

// For use below: add OffsetModifier in ViewModifiers
/*
 
 //MARK: - For running line

 struct OffsetModifier: ViewModifier, Animatable {
     
     private let maxOffset: CGFloat
     private let rewindSpeedFactor: Int
     private let endWaitFraction: CGFloat
     private var progress: CGFloat
     
     // The progress value at which the end wait begins
     private let endWaitThreshold: CGFloat
     
     // The progress value at which rewind begins
     private let rewindThreshold: CGFloat
     
     init(
         maxOffset: CGFloat,
         rewindSpeedFactor: Int = 4, //Default: 4
         endWaitFraction: CGFloat = 0,
         progress: CGFloat
     ) {
         self.maxOffset = maxOffset
         self.rewindSpeedFactor = rewindSpeedFactor
         self.endWaitFraction = endWaitFraction
         self.progress = progress
         
         // Compute the thresholds for waiting and for rewinding
         let rewindFraction = (CGFloat(1) - endWaitFraction) / CGFloat(rewindSpeedFactor + 1)
         self.rewindThreshold = CGFloat(1) - rewindFraction
         self.endWaitThreshold = CGFloat(1) - rewindFraction - endWaitFraction
     }
     
     /// Implementation of protocol property
     var animatableData: CGFloat {
         get { progress }
         set { progress = newValue }
     }
     
     var xOffset: CGFloat {
         let fraction: CGFloat
         if progress > rewindThreshold {
             fraction = endWaitThreshold - ((progress - rewindThreshold) * CGFloat(rewindSpeedFactor))
         } else {
             fraction = min(progress, endWaitThreshold)
         }
         return endWaitThreshold > 0 ? (fraction / endWaitThreshold) * maxOffset : 0
     }
     
     func body(content: Content) -> some View {
         content.offset(x: xOffset)
     }
 }


 */



/* Usage:
 
var body: some View {
    VStack{
        GeometryReader { proxy in
            RewindingTextTicker(textKey: address, viewWidth: proxy.size.width)
        }
        .frame(height: 10)
    }
    .padding(.horizontal, 20)
}
 
*/
