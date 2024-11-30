import SwiftUI

struct ContentView: View {
    @State private var selectedFacility = Facilities.list[0] // Default to the first facility
    @State private var selectedDate = Date()
    @State private var events: [Event] = []
    @State private var dateString: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }()

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                Color(hex: "#FDC700") // UCSC Blue (slightly lighter)
                    .ignoresSafeArea(edges: .top)

                VStack(spacing: 10) {
                    Text("UCSC Facility Schedule")
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                        .foregroundColor(.black) // UCSC Gold
                        .padding(.top, 20)

                    HStack {
                        Button(action: {
                         
                            selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) ?? selectedDate
                            dateString = (dateFormatter.string(from: selectedDate))


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
                            .onChange(of: selectedDate) { oldValue, newValue in
                                Task {
                                    await loadEvents()
                                }
                            }
                        Button(action: {
                            selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
                            dateString = (dateFormatter.string(from: selectedDate))
                        })
                        {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 5)
                    .background(Color(hex: "FDC700")) 
                    .foregroundColor(.white)
                }
            }
            .frame(height: 140)

            // Main Content
            VStack(alignment: .leading, spacing: 20) {
                Picker("Select Facility", selection: $selectedFacility) {
                    ForEach(Facilities.list, id: \.self) {
                        Text($0)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center)
                .pickerStyle(MenuPickerStyle())
                .padding(.horizontal)
                .frame(height: 60)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)

                DayView(events: events)
            }
            .padding()
            .background(Color(hex: "#F9F6E5").opacity(0.6))

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#F9F6E5").opacity(0.4))
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            Task {
                await loadEvents()
            }
        }
    }
    
    
    func loadEvents() async {
        do {
            let dateString = dateFormatter.string(from: selectedDate)
            let endDate = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!)

            events = try await fetchEvents(start: dateString, end: endDate)
            print(events)
            
            // Get start of day
        } catch {
            print("Error loading events: \(error)")
        }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
