import SwiftUI

import SwiftUI

struct ContentView: View {
    var facilities = [
        "Online > Zoom",
        "West Campus > West Tennis Courts (WTC) > WTC - Court 6",
        "West Campus > West Tennis Courts (WTC) > WTC - Court 5",
        "West Campus > West Tennis Courts (WTC) > WTC - Court 3",
        "West Campus > West Tennis Courts (WTC) > WTC - Court 4",
        "West Campus > West Tennis Courts (WTC) > WTC - Court 1",
        "West Campus > West Tennis Courts (WTC) > WTC - Court 2",
        "Off Campus > Westside Research Park Tennis Courts",
        "West Campus > West Tennis Courts (WTC)",
        "West Campus > West Field House",
        "West Campus > West Sand Courts",
        "West Campus > West Field",
        "West Campus",
        "East Field House Complex > Team Locker Room (Men)",
        "Vehicles",
        "East Field House Complex > Team Locker Rooms (Women)",
        "East Field House Complex > Meeting Spaces > Slug Space",
        "Online",
        "East Field House Complex > Multi-Purpose Room",
        "East Field House Complex > Meeting Spaces",
        "East Field House Complex > Meeting Spaces > Meeting Room 211A",
        "East Field House Complex > Martial Arts Studio",
        "Off Campus > Kaiser Permanente Arena",
        "East Field House Complex > Jogging Path",
        "East Field House Complex > Fitness Center",
        "East Field House Complex > ETC - East Tennis Courts",
        "East Field House Complex > ETC - East Tennis Courts > ETC - Court 5",
        "East Field House Complex > ETC - East Tennis Courts > ETC - Court 6",
        "East Field House Complex > ETC - East Tennis Courts > ETC - Court 4",
        "East Field House Complex > ETC - East Tennis Courts > ETC - Court 3",
        "East Field House Complex > ETC - East Tennis Courts > ETC - Court 2",
        "East Field House Complex > ETC - East Tennis Courts > ETC - Court 1",
        "East Field House Complex > East Upper Field",
        "East Field House Complex > East Sand Courts",
        "East Field House Complex > East Outdoor Basketball Courts",
        "East Field House Complex > East Lower Field",
        "East Field House Complex > East Gym",
        "East Field House Complex",
        "East Field House Complex > Disc Golf Course",
        "East Field House Complex > Dance Studio",
        "East Field House Complex > Activities Room",
        "East Field House Complex > Meeting Spaces > Conference Room",
        "East Field House Complex > 50m Pool",
        "East Field House Complex > 50m Pool > 50m Pool - Deep End Only",
        "East Field House Complex > 50m Pool > 50m Pool - Shallow End Only"
    ]
    @State private var selectedFacility = "West Campus > West Field House"
    @State private var selectedDate = Date()

    
    // #FDC700" gold
    var body: some View {
        VStack(spacing: 0) {
            // Header with Date Picker
            ZStack(alignment: .bottom) {
                Color(hex: "#FDC700") // UCSC Blue (slightly lighter)
                    .ignoresSafeArea(edges: .top)

                VStack(spacing: 10) {
                    Text("UCSC Facility Schedule")
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                        .foregroundColor(.black) // UCSC Gold
                        .padding(.top, 20)

                    // Date Picker
                    HStack {
                        Button(action: {
                            selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) ?? selectedDate
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .padding()
                        }

                        DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                            .labelsHidden()
                            .background(Color.blue) // Background color
                            .cornerRadius(8)
                            .padding(.horizontal)
                            .colorScheme(.dark) // Makes the text white in DatePicker's default behavior
                        Button(action: {
                            selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
                        })
                        {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 5)
                    .background(Color(hex: "FDC700")) // UCSC Gold
                    .foregroundColor(.white)
                }
            }
            .frame(height: 140)

            // Main Content
            VStack(alignment: .leading, spacing: 20) {
                // Facility Picker
                VStack(alignment: .leading, spacing: 8) {
                    Text("Select Facility")
                        .font(.headline)
                        .foregroundColor(Color(hex: "#0266A8")) // UCSC Blue
                        .frame(maxWidth: .infinity, alignment: .center) // Center the text

                    Picker("Select Facility", selection: $selectedFacility) {
                        ForEach(facilities, id: \.self) {
                            Text($0)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center) // Center the picker
                    .pickerStyle(MenuPickerStyle())
                    .padding(.horizontal)
                    .frame(height: 60)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                }
                DayView()
            }
            .padding()
            .background(Color(hex: "#F9F6E5").opacity(0.6)) // Soft UCSC Gold background

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#F9F6E5").opacity(0.4)) // Light UCSC Gold background
        .ignoresSafeArea(edges: .bottom)
        
        
    }
}


// Preview

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

// TODO: Create a custom ScheduleBlock view

#Preview {
    ContentView()
}
