import Foundation


struct Event: Decodable {
    let id: String
    let title: String
    let start: String
    let end: String
    let backgroundColor: String
    let textColor: String
    let allDay: Bool
}

func fetchEvents(id: String, start: Date, end: Date) async throws -> [Event] {
    guard let url = URL(string: "https://campusrec.ucsc.edu/Facility/GetScheduleCustomAppointments?selectedId=dce84fd0-83b4-4dbc-8f0e-5b614adf3f88&start=2024-11-26T00%3A00%3A00-08%3A00&end=2024-11-27T00%3A00%3A00-08%3A00") else {
    }
    print("seccccccc ")

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
