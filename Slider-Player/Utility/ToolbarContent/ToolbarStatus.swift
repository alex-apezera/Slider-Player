import SwiftUI

struct ToolbarStatus: View {
    var title: String
    var isLoading: Bool
    var lastUpdated: TimeInterval
    var count: Int

    var body: some View {
        VStack {
            if isLoading {
                Text("Checking for \(title)...")
                Spacer()
            } else if lastUpdated == Date.distantFuture.timeIntervalSince1970 {
                Spacer()
                Text("\(count) \(title)")
                    .foregroundStyle(Color.secondary)
            } else {
                let lastUpdatedDate = Date(timeIntervalSince1970: lastUpdated)
                Text("Updated \(lastUpdatedDate.formatted(.relative(presentation: .named)))")
                Text("\(count) \(title)")
                    .foregroundStyle(Color.secondary)
            }
        }
        .font(.caption)
    }
}
