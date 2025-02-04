import Coordinator
import Router
import SwiftUI

struct ContentView: View {
  @State private var router = Router()
  
  var body: some View {
    // TODO: - Splash 화면으로 변경
    NavigationStack(path: $router.path) {
      Coordinator.view(for: .home)
        .navigationDestination(for: Route.self) { route in
          Coordinator.view(for: route)
        }
    }
    .toolbar(.hidden)
    .environment(router)
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
