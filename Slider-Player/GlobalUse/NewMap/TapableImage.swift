//
//  TapableImage.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 30.10.2026.
//
/*
import SwiftUI
import UIKit

/// Не доработанный функционал
/// Dont work correctly (not works with  .video)
struct TappableImageView: UIViewRepresentable {
    let image: UIImage?
    let onTap: () -> Void
    let onLongPress: () -> Void

    func makeUIView(context: Context) -> UIImageView {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 4
        iv.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleTap)
        )
        tap.cancelsTouchesInView = true

        let lp = UILongPressGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleLong)
        )
        lp.minimumPressDuration = 0.5
        lp.cancelsTouchesInView = true
        lp.delaysTouchesBegan = false

        // 🔑 гарантия приоритета над жестами MKMapView
        lp.require(toFail: tap)   // long-press ждёт, пока tap «провалится»
        // tap срабатывает сразу, long-press — только если палец продержался 0.5с
        // и tap так и не «выстрелил»

        tap.delegate = context.coordinator
        lp.delegate = context.coordinator

        iv.addGestureRecognizer(tap)
        iv.addGestureRecognizer(lp)
        return iv
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.image = image
        context.coordinator.onTap = onTap
        context.coordinator.onLongPress = onLongPress
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(onTap: onTap, onLongPress: onLongPress)
    }

    final class Coordinator: NSObject, UIGestureRecognizerDelegate {
        var onTap: () -> Void
        var onLongPress: () -> Void
        init(onTap: @escaping () -> Void, onLongPress: @escaping () -> Void) {
            self.onTap = onTap
            self.onLongPress = onLongPress
        }

        @objc func handleTap()              { onTap() }
        @objc func handleLong(_ g: UILongPressGestureRecognizer) {
            if g.state == .began { onLongPress() }   // только начало, не ended
        }

        // не даём MKMapView «перехватывать» наши жесты
        func gestureRecognizer(
            _ gestureRecognizer: UIGestureRecognizer,
            shouldRecognizeSimultaneouslyWith other: UIGestureRecognizer
        ) -> Bool { false }

        func gestureRecognizer(
            _ gestureRecognizer: UIGestureRecognizer,
            shouldBeRequiredToFailBy other: UIGestureRecognizer
        ) -> Bool { false }
    }
}
*/
