//
//  Astros.swift
//  finalProject
//
//  Created by HARMON, AUDREY on 5/1/24.
//

import SwiftUI

struct Astros: Codable {
    let message: String
    let people: People
}

struct People: Codable {
    let name: String
    let craft: String
}

struct Astronauts: View {
    @State var responseData3: Astros?
    public var body: some View {
        VStack {
            if let responseData3 = responseData3 {
                Text("Astronomy Picture of the Day")
                    .bold(true)
                Text("\(responseData3.people.name)")
            } else {
                Text("Loading data...")
            }
        } .onAppear{
            getAstronauts()
        }
    }
    
    private func getAstronauts(){
        guard let url = URL(string: "http://api.open-notify.org/astros.json") else {
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
                let response = try decoder.decode(Astros.self, from: data)
                DispatchQueue.main.async {
                    self.responseData3 = response
                    print(self.responseData3)
                }
                print(response)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}

#Preview {
    Astronauts()
}
