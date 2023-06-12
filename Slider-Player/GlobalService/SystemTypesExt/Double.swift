//
//  Double.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 23.11.2024.
//

import Foundation

//MARK: - Double Fomatter for Bubble
extension Double {
    func describeAsFixedLengthString(integerDigits: Int = 2, fractionDigits: Int = 2) -> String {
        self.formatted(
            .number
                .sign(strategy: .always())
                .precision(
                    .integerAndFractionLength(integer: integerDigits, fraction: fractionDigits)
                )
        )
    }

//MARK: - Double Formatter for Weather

    func formattedValue(style: NumberFormatter.Style = .decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = style

        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
