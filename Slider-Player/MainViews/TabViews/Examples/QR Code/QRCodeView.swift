//
//  QRCodeView + QRCodeGeneratorView
//  Slider-Player
//
//  Created by Алексей Езерский on 26.04.2023.
//
//  QR Code Generator View
// https://www.youtube.com/channel/UCvsJ3k3CFcRq3eJnUoU3u2w

import SwiftUI

struct QRCodeGeneratorView: View {
    @Binding var webUrl: String
    
    @AppStorage("urlInput") var urlInput: String = ""
    @State private var qrCode: QRCode?
    
    private let qrCodeGenerator = QRCodeGenerator()
    @StateObject private var imageSaver = ImageSaver()
    
    var createQRurl: String {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        if let _ = windowScene {
            qrCode = qrCodeGenerator.generateQRCode(forUrlString: urlInput)
        }
        return urlInput
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    TextField(String.enterUrl, text: $urlInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textContentType(.URL)
                        .keyboardType(.URL)
                    
                    if !urlInput.isEmpty {
                        AnyButton(icon: "xmark.circle") { urlInput = "" }
                    }
                    
                    AnyButton(icon: "qrcode") { webUrl = createQRurl }
                    .disabled(urlInput.isEmpty)
                    .padding(.leading)
                    
                    AnyButton(icon: "square.and.arrow.up") {
                        assert(qrCode != nil, .cannotSaveImage)
                        imageSaver.saveImage(webUrl, qrCode!.uiImage)
                    }
                    .disabled(qrCode == nil)
                    .alert(item: $imageSaver.saveResult) { saveResult in
                        return alert(forSaveStatus: saveResult.saveStatus)
                    }
                }
                Spacer()
                if qrCode == nil || urlInput.isEmpty {
                    EmptyStateView(width: geometry.size.width)
                } else {
                    NavigationLink(destination: WebContentView(webUrl: webUrl)) {
                        QRCodeView(qrCode: qrCode!, width: geometry.size.width) }
                }
                Spacer()
            }
            .underline(false)
            .padding()
            .navigationBarTitle(String.qrCodeGenerator)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func alert(forSaveStatus saveStatus: ImageSaveStatus) -> Alert {
        switch saveStatus {
        case .success:
            return Alert(
                title: Text(String.success),
                message: Text(verbatim: .successMessage),
                dismissButton: .cancel(Text(String.actionOK))
            )
        case .error:
            return Alert(
                title: Text(verbatim: .oops),
                message: Text(verbatim: .oopsMessage),
                dismissButton: .cancel(Text(String.cancel))
            )
        case .libraryPermissionDenied:
            return Alert(
                title: Text(verbatim: .oops),
                message: Text(verbatim: .oopsMessage2),
                primaryButton: .cancel(Text(String.actionOK)),
                secondaryButton: .default(Text(verbatim: .openSettings)) {
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                    UIApplication.shared.open(settingsUrl)
                }
            )
        }
    }
}

struct QRCodeView: View {
    let qrCode: QRCode
    let width: CGFloat
    
    var body: some View {
        VStack {
            Label("\(.qrCodeFor) \(qrCode.urlString):", systemImage: "qrcode.viewfinder")
                .lineLimit(3)
            Image(uiImage: qrCode.uiImage)
                .resizable()
                .frame(width: width * 2 / 3, height: width * 2 / 3)
        }
    }
}

struct EmptyStateView: View {
    let width: CGFloat
    private var imageLength: CGFloat { width / 2.5 }
    
    var body: some View {
        VStack {
            Image(systemName: "qrcode")
                .resizable()
                .frame(width: imageLength, height: imageLength)
            Text(verbatim: .createQrCode)
                .padding(.top)
        }
        .foregroundColor(Color(UIColor.systemGray))
    }
}
