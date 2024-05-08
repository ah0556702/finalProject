import SwiftUI


struct ContentView: View {
    
    var body: some View {

        TabView {
            Astronauts()
                .tabItem {
                    Label("Astronauts", systemImage: "person")
                }
            POD()
                .tabItem {
                    Label("POD", systemImage: "book")
                }
            
            ISSMap()
                .tabItem {
                    Label("ISS", systemImage: "book")
                }
        }
    }
}

    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

 

 
