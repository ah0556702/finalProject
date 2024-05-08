//
//  Astros.swift
//  finalProject
//
//  Created by HARMON, AUDREY on 5/1/24.
//

import SwiftUI

struct AstronautResponse: Codable {
    let message: String
    let people: [People]
    let number: Int
}

struct People: Codable {
    let name: String
    let craft: String
}

struct Astronauts: View {
    @State var responseData3: AstronautResponse?
    public var body: some View {
        ZStack(alignment:.bottom) {
//            RadialGradient(gradient: Gradient(colors: [Color(red: 0, green: 0, blue: 0.2), Color.black, Color.white]), center: .center, startRadius: 2, endRadius: 650)
//                .ignoresSafeArea()
            
            
            
            VStack {
                if let responseData3 = responseData3?.people {
                    Text("ISS Astronauts")
                        .bold(true)
                    
                    List(responseData3, id: \.name) {
                        astronaut in
                        Text(astronaut.name)
                    }.scrollContentBackground(.hidden)
                    
                } else {
                    Text("Loading data...")
                }
            }
            Image("overlay")
                .resizable()
                .scaledToFit()
            
            }.onAppear{
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
                let response = try decoder.decode(AstronautResponse.self, from: data)
                DispatchQueue.main.async {
                    self.responseData3 = response
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
