//
//  POD.swift
//  finalProject
//
//  Created by HARMON, AUDREY on 5/6/24.
//

import SwiftUI
import AVKit


struct NasaPicture: Codable {
    let date: String
    let explanation: String
    let title: String
    let url: String
}

struct POD: View {
    @State private var responseData2: NasaPicture?
    var body: some View {
        VStack {
            if let responseData2 = responseData2 {
                Text("Astronomy Picture of the Day")
                    .bold(true)
                AsyncImage(url: URL(string: responseData2.url)) {
                    image in
                    image.resizable()
                } placeholder: {
                    Color.black
                }
                .frame(width: 328, height: 228)
                .clipShape(.rect(cornerRadius: 25))
                Text("\(responseData2.explanation)")
            } else {
                Text("Loading data...")
            }
        }
        .onAppear {
            fetchPod()
        }
    }
        
        private func fetchPod() {

            guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY") else {
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
                    let apiresponse = try decoder.decode(NasaPicture.self, from: data)
                    DispatchQueue.main.async {
                        self.responseData2 = apiresponse
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }.resume()
        }
}
    
    

#Preview {
    POD()
}
