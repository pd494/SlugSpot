//
//  DayView.swift
//  SlugSpot
//
//  Created by Prasanth Dendukuri on 11/25/24.
//

import SwiftUI

struct DayView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(6...23, id: \.self) { hour in
                    Text(formatHour(hour)) // Call helper function to format hour
                        .padding(.vertical, 13) // Adjust spacing for readability
                        .padding(.horizontal, 5)
                        .foregroundColor(Color(hex: "#014E9B")) // Set text color to UCSC Blue

                    Divider() // Add a line between each row
                }
            }
        }
    }

    // Helper function inside `DayView`
    func formatHour(_ hour: Int) -> String {
        if hour == 12 {
            return "12 PM"
        } else if hour == 0 || hour == 24 {
            return "12 AM"
        } else if hour < 12 {
            return "\(hour) AM"
        } else {
            return "\(hour - 12) PM"
        }
    }
    
    
    
}

#Preview {
    DayView()
}
