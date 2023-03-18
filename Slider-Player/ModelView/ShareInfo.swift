//
//  ShareInfo.swift
//  Slider-Player
//
//  Created by Алексей Езерский on 05.04.2023.
//

import SwiftUI

struct Photo: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.image)
    }

    public var image: Image
    public var caption: String
}
struct PhotoView: View {
    let photo: Photo

    var body: some View {
        photo.image
            .toolbar {
                ShareLink(
                    item: photo,
                    preview: SharePreview(
                        photo.caption,
                        image: photo.image))
            }
    }
}


struct ShareInfo: View {
    
    var body: some View {
        
        let link = URL(string: "https://www.hackingwithswift.com")!
        let linkSW = URL(string: "https://www.admin.ch")!
        
        VStack(spacing: 20) {
       
            ShareLink(item: link) {
                Label("Learn Swift here", systemImage: "swift")
            }
            
            ShareLink(
                item: linkSW,
                preview: SharePreview(
                    "Switzerland's flag: it's a big plus.",
                    image: Image("plus")
                )
            )
        }
    }
}

struct ShareInfo_Previews: PreviewProvider {
    static var previews: some View {
        ShareInfo()
    }
}
