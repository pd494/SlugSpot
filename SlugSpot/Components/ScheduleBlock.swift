import SwiftUI

struct ScheduleBlock: View {
    let title: String
    let startTime: String
    let endTime: String
    let textColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(textColor)
                .lineLimit(1)
            
            Text("\(startTime) - \(endTime)")
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
