//
//  ISSMap.swift
//  spaceTeam
//
//  Created by HARMON, AUDREY on 4/24/24.
//

import SwiftUI
import MapKit

// Define the struct to represent the JSON response

//struct Map<Content> where Content : View

struct ISSResponse: Codable {

    let message: String
    let timestamp: Int
    let issPosition: ISSPosition

    enum CodingKeys: String, CodingKey {
        case message
        case timestamp
        case issPosition = "iss_position"
    }
}

struct ISSPosition: Codable {
    let latitude: Double
    let longitude: Double
}

struct ISSMap: View {
    @State var responseData: ISSResponse?
    public var body: some View {
        Text("Hello World")
    }

    private func fetchData() {

        guard let url = URL(string: "http://api.open-notify.org/iss-now.json") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in

            guard let data = data else {
                print("No data received")
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ISSResponse.self, from: data)
                DispatchQueue.main.async {
                    self.responseData = response
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}

struct ISSMap_Previews:PreviewProvider {
    static var previews: some View {
        ISSMap()
    }
}
