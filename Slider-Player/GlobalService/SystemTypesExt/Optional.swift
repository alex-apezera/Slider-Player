//
//  Optional.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 20.12.2024.
//
/*
import Foundation

extension Optional: @retroactive RawRepresentable where Wrapped: Codable {
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8) else {
            return "{}"
        }
        
        return result
    }
    
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(Self.self, from: data) else {
            return nil
        }
        
        self = result
    }
}
*/
