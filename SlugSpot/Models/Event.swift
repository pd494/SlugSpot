import Foundation


struct Event: Identifiable, Decodable {
    let id: String
    let title: String
    let start: String
    let end: String
    let backgroundColor: String
    let textColor: String
    let allDay: Bool
}

func fetchEvents(start: String, end: String) async throws -> [Event] {
    guard let url = URL(string: "https://campusrec.ucsc.edu/Facility/GetScheduleCustomAppointments?selectedId=dce84fd0-83b4-4dbc-8f0e-5b614adf3f88&start=\(start)T00%3A00%3A00-08%3A00&end=\(end)T00%3A00%3A00-08%3A00") else {
        throw URLError(.badURL)
    }
    
    print("Fetching URL: \(url)") // Debug print


    let (data, _) = try await URLSession.shared.data(from: url)
    let decoded = try JSONDecoder().decode([Event].self, from: data)
    return decoded
}

//Task {
//    do {
//        let movies = try await fetchEvents()
//
//        print(movies)
//    } catch {
//        print(error)
//    }
//}
