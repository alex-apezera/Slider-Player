//
//  MPVolumeView.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 23.11.2024.
//

import MediaPlayer

//MARK: - Volume regulation

extension MPVolumeView {
    static func setVolume(_ volume: Float) -> Void {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume
        }
    }
}
