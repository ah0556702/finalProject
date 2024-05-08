import SwiftUI
import AVKit


struct ContentView: View {
    
    var body: some View {

        TabView {
            Astronauts()
                .tabItem {
                    Label("Astronauts", systemImage: "moon.stars")
                }
            POD()
                .tabItem {
                    Label("POD", systemImage: "star")
                }
            
            ISSMap()
                .tabItem {
                    Label("ISS", systemImage: "mappin.and.ellipse")
                }
        }
    }
}

    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

 

 
