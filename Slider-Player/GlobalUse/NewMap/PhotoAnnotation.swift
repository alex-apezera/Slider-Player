//
//  PhotoAnnotation.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 29.10.2026.
//

import SwiftUI

struct PhotoAnnotation: View {
    let item: Int
    let url: URL
    @Binding var isBig: Bool
    var onLongPress: () -> Void = {}

    @State private var image: Image = Image(systemName: "photo")
    @State private var uiImage: UIImage? = nil   // ← ошибка 1 решена
    
    @GestureState private var pressing = false

    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 0.4)
            .updating($pressing) { value, state, _ in
                state = value
            }
            .onEnded { _ in onLongPress() }
    }

    private var side: CGFloat { isBig ? 100 : 35 }
    private var crossUp: CGFloat { isBig ? 70 : 0 }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5).fill(.background)
            RoundedRectangle(cornerRadius: 5).stroke(.secondary, lineWidth: 1)
/*
            // Dont work correctly
            TappableImageView(
                image: uiImage,
                onTap: {
                    withAnimation(.easeInOut(duration: 0.2)) { isBig.toggle() }
                },
                onLongPress: onLongPress
            )
*/
            image.resizable()
                .scaledToFill()
                .frame(width: side, height: side)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(2)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: 1.0)) {isBig.toggle()}
        }
        .simultaneousGesture(longPress)
        .offset(x: crossUp, y: crossUp)
        .task { image = await imageOnMap(url: url) }
//        .task(id: url) { uiImage = await loadUIImage(url: url) }
        .animation(.easeInOut(duration: 1.0), value: isBig)
//        .id(isBig)
    }
}
/*
/// Dont work correctly (not loading .video)
func loadUIImage(url: URL) async -> UIImage? {
    guard let (data, _) = try? await URLSession.shared.data(from: url) else {
        return nil
    }
    if let image = UIImage(data: data) {
        return image
    }
    return nil
}
*/
