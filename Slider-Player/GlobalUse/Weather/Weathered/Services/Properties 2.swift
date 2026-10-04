//
//  Properties.swift
//  Weathered
//
//  Created by Алексей Езерский on 12.09.2024.
//

import SwiftUI

//MARK: - Item View
@ViewBuilder func itemView(size: CGFloat, item: some View) -> some View {
    Rectangle()
        .frame(width: size, height: 17)
        .foregroundStyle(.clear)
        .opacity(0.2)
        .overlay {
            HStack {
                item.font(.footnote).lineLimit(1)
                Spacer()
            }
        }
}


//MARK: Rendering Icon of Metric
    func iconRendering(_ value: Double, for metric: String) -> some View {
        HStack {
            switch metric {
            case .feelsLike, .maxTemp, .minTemp, .temperature: tempIcon(for: value)
            case .clouds: cloudinessIcon(Int(value))
            case .pressure: pressureIcon(Int(value))
            case .humidity: humidityIcon(Int(value))
            case .visibility: visibilityIcon(Int(value))
            case .uvIndex: uvIndexIcon(Int(value))
            case .maxWind, .wind: windIcon(value)
            case .sunrise: sunriseIcon()
            case .sunset: sunsetIcon()
            case .moonrise: moonriseIcon()
            case .moonset: moonsetIcon()
            case .totalPrecpt, .precipitation, .precipMm: rainIcon(value)
            case .totalSnow, .snowCm: snowIcon(value)
            case .rainChance: rainChanceIcon(value)
            case .snowChance: snowChanceIcon(value)
            default: windIcon(value)
            }
        }
    }
//MARK: - Sunrise icon
func sunriseIcon() -> some View {
    Image(systemName: "sunrise")
        .symbolRenderingMode(.palette)
        .foregroundStyle(.cyan, .yellow)
}
//MARK: - Sunrise icon
func sunsetIcon() -> some View {
    Image(systemName: "sunset")
        .symbolRenderingMode(.palette)
        .foregroundStyle(.indigo, .orange)
}
//MARK: - Moonrise icon
func moonriseIcon() -> some View {
    Image(systemName: "moon.stars")
        .symbolRenderingMode(.palette)
        .foregroundStyle(.blue, .cyan)
}
//MARK: - Sunrise icon
func moonsetIcon() -> some View {
    Image(systemName: "moon.zzz")
        .symbolRenderingMode(.palette)
        .foregroundStyle(.indigo, .orange)
}
//MARK: - Rendering themperatue
func tempIcon(for temp: Double) -> some View {
    HStack {
        if temp > 30 {
            Image(systemName: "thermometer.high")
                .foregroundStyle(.red, .red, .cyan)
        } else if temp <= 30 && temp > 15 {
            Image(systemName: "thermometer.medium")
                .foregroundStyle(.orange, .red, .cyan)
        } else if temp <= 15 && temp > 3 {
            Image(systemName: "thermometer.medium")
                .foregroundStyle(.yellow, .orange, .cyan)
        } else {
            Image(systemName: "thermometer.low")
                .foregroundStyle(.indigo, .orange, .cyan)
        }
    }
    .symbolRenderingMode(.palette)
}
//MARK: - Rendering cloudiness quantity
func cloudinessIcon(_ quantity: Int) -> some View {
    let clearRange = 0...20
    let partlyCloudy = 21...60
    let cloudy = 61...80
    return HStack {
        if clearRange.contains(quantity) {
            Image(systemName: "sun.max")
                .foregroundStyle(.orange)
        } else if partlyCloudy ~= quantity {
            Image(systemName: "cloud.sun")
        } else if cloudy ~= quantity {
            Image(systemName: "smoke.fill")
        } else {
            Image(systemName: "cloud.fill")
                .foregroundStyle(.indigo)
        }
    }
    .symbolRenderingMode(.palette)
    .foregroundStyle(.cyan, .orange)
}
//MARK: - Rendering wind quantity
func windIcon(_ quantity: Double) -> some View {
    HStack {
        if quantity >= 0 && quantity < 15 {
            Image(systemName: "wind")
                .foregroundStyle(.cyan)
        } else if quantity >= 15 && quantity < 60 {
            Image(systemName: "wind")
                .foregroundStyle(.orange)
        } else {
            Image(systemName: "wind")
                .foregroundStyle(.red)
        }
    }
}
//MARK: - Rendering rain quantity
    func rainIcon(_ quantity: Double) -> some View {
        HStack {
            if quantity >= 0.1 && quantity < 1 {
                if #available(iOS 17.0, *) {
                    Image(systemName: "drop.halffull")
                } else {
                    Image(systemName: "drop.circle")
                }
            } else if quantity >= 1 && quantity < 2 {
                Image(systemName: "cloud.rain")
            } else if quantity >= 2 && quantity < 3 {
                Image(systemName: "cloud.heavyrain")
            } else if quantity >= 3 {
                Image(systemName: "cloud.heavyrain.fill")
                    .foregroundStyle(.indigo, .blue)
            } else {
                Image(systemName: "drop")
            }
        }
        .symbolRenderingMode(.palette)
        .foregroundStyle(.cyan, .blue)
    }
//MARK: - Rendering rain chance
    func rainChanceIcon(_ quantity: Double) -> some View {
        HStack {
            if quantity >= 0 && quantity < 10 {
                Image(systemName: "drop")
                    .foregroundStyle(.cyan)
            } else if quantity >= 10 && quantity < 50 {
                Image(systemName: "drop.halffull")
                    .foregroundStyle(.blue)
            } else {
                Image(systemName: "drop.fill")
                    .foregroundStyle(.indigo)
            }
        }
    }
//MARK: - Rendering snow quantity
    func snowIcon(_ quantity: Double) -> some View {
        HStack {
            if quantity >= 0 && quantity < 0.1 {
                Image(systemName: "snow")
                    .foregroundStyle(.cyan)
            } else if quantity >= 0.1 && quantity < 2 {
                Image(systemName: "snow")
                    .foregroundStyle(.blue)
            } else {
                Image(systemName: "snow")
                    .foregroundStyle(.indigo)
            }
        }
    }
//MARK: - Rendering snow chance
    func snowChanceIcon(_ quantity: Double) -> some View {
        HStack {
            if quantity >= 0 && quantity < 10 {
                Image(systemName: "snowflake.circle")
                    .foregroundStyle(.cyan, .green)
            } else if quantity >= 10 && quantity < 50 {
                Image(systemName: "snowflake.circle")
                    .foregroundStyle(.cyan, .yellow)
            } else if quantity >= 50 && quantity < 85 {
                Image(systemName: "snowflake.circle")
                    .foregroundStyle(.blue, .orange)
            } else {
                Image(systemName: "snowflake.circle")
                    .foregroundStyle(.indigo, .red)
            }
        }
        .symbolRenderingMode(.palette)

    }


//MARK: - Rendering pressure quantity
func pressureIcon(_ quantity: Int) -> some View {
    HStack {
        if quantity > 1015 {
            if #available(iOS 17.0, *) {
                Image(systemName: "gauge.with.dots.needle.67percent")
                    .foregroundStyle(.red, .blue)
            } else {
                Image(systemName: "arrow.down.right.and.arrow.up.left.circle")
                    .foregroundStyle(.red, .blue)
            }
        } else if quantity <= 1015 && quantity > 995 {
            if #available(iOS 17.0, *) {
                Image(systemName: "gauge.with.dots.needle.50percent")
                    .foregroundStyle(.orange, .cyan)
            } else {
                Image(systemName: "arrow.down.right.and.arrow.up.left.circle")
                    .foregroundStyle(.orange, .cyan)
            }
        } else {
            if #available(iOS 17.0, *) {
                Image(systemName: "gauge.with.dots.needle.33percent")
                    .foregroundStyle(.red, .mint)
            } else {
                Image(systemName: "arrow.up.left.and.arrow.down.right.circle")
                    .foregroundStyle(.red, .mint)
            }
        }
    }
    .symbolRenderingMode(.palette)
}
//MARK: - Rendering humidity quantity
func humidityIcon(_ quantity: Int) -> some View {
    let dry = 0...20
    let comfort = 21...60
    let wet = 61...85
    return HStack {
        if dry.contains(quantity) {
            Image(systemName: "humidity")
                .foregroundStyle(.yellow, .red)
        } else if comfort ~= quantity {
            Image(systemName: "humidity")
                .foregroundStyle(.cyan, .orange)
        } else if wet ~= quantity {
            Image(systemName: "humidity.fill")
                .foregroundStyle(.blue, .teal)
        } else {
            Image(systemName: "humidity.fill")
                .foregroundStyle(.blue, .indigo)
        }
    }
    .symbolRenderingMode(.palette)
}
//MARK: - Rendering visibility quantity
    func visibilityIcon(_ quantity: Int) -> some View {
        HStack {
            if quantity > 8 {
                Image(systemName: "eye")
                    .foregroundStyle(.cyan)
            } else if quantity <= 8 && quantity > 1 {
                Image(systemName: "eye.trianglebadge.exclamationmark")
                    .foregroundStyle(.orange, .cyan)
            } else {
                Image(systemName: "eye.trianglebadge.exclamationmark")
                    .foregroundStyle(.yellow, .indigo)
            }
        }
        .symbolRenderingMode(.palette)
    }
//MARK: - Rendering UV index
    func uvIndexIcon(_ quantity: Int) -> some View {
        HStack {
            if quantity > 7 {
                Image(systemName: "sun.max.trianglebadge.exclamationmark.fill")
                    .foregroundStyle(.pink, .yellow)
            } else if quantity <= 7 && quantity > 4 {
                Image(systemName: "sun.max.trianglebadge.exclamationmark")
                    .foregroundStyle(.red, .yellow)
            } else {
                Image(systemName: "sun.max.trianglebadge.exclamationmark")
                    .foregroundStyle(.green, .orange)
            }
        }
        .symbolRenderingMode(.palette)
    }
