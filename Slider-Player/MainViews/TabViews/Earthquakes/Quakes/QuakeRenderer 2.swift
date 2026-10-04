//
//  QuakeRenderer.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 07.11.2024.
//

import SwiftUI

//MARK: - Text shake with amount

@available(iOS 17.0, *)
struct QuakeRenderer: TextRenderer {
    var moveAmount: Double

    var animatableData: Double {
        get { moveAmount }
        set { moveAmount = newValue }
    }

    func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        for line in layout {
            for run in line {
                for glyph in run {
                    var copy = context
                    let yOffset = moveAmount>0 ? Double.random(in: -moveAmount...moveAmount) : 0

                    copy.translateBy(x: 0, y: yOffset)
                    copy.draw(glyph, options: .disablesSubpixelQuantization)
                }
            }
        }
    }
}
