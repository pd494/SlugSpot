import SwiftUI

struct DayView: View {
    let events: [Event] // Importing Event from your Event struct
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(6...23, id: \.self) { hour in
                    // Display the hour (AM/PM)
                    Text(formatHour(hour))
                        .padding(.vertical, 13)
                        .padding(.horizontal, 5)
                        .foregroundColor(Color(hex: "#014E9B"))
                    
                    // Divider between each hour
                    Divider()
                    
                    // Display events for this hour
                    VStack {
                        ForEach(events.filter { isEventInHour($0, hour: hour) }, id: \.id) { event in
                            Text(event.title)
                                .padding(8)
                                .background(Color.blue)
                                .cornerRadius(5)
                                .foregroundColor(Color.white)
                        }
                    }
                    .padding(.leading, 15) // Indent the event text
                }
            }
        }
    }

    // Helper function to format the hour into AM/PM
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
    
    // Helper function to check if an event is within a given hour
    func isEventInHour(_ event: Event, hour: Int) -> Bool {
        // Split the ISO8601 date string at "T" and extract the hour portion
        let eventStartHour = extractHour(from: event.start)
        let eventEndHour = extractHour(from: event.end)
        
        // Check if the event is within the given hour
        return (eventStartHour <= hour && eventEndHour > hour)
    }
    
    // Helper function to extract hour from ISO8601 string
    func extractHour(from dateString: String) -> Int {
        // Split the string at "T" to separate date and time
        let components = dateString.split(separator: "T")
        // Extract the time portion, which is the second component
        if components.count > 1 {
            let timeString = components[1]
            // Extract the first two characters (the hour) from the time portion
            let hourString = timeString.prefix(2)
            if let hour = Int(hourString) {
                return hour
            }
        }
        return 0 // Return 0 if hour extraction fails
    }
}
