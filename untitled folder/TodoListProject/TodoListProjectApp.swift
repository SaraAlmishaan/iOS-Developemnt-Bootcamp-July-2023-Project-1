import SwiftUI

@main
  struct TodoListProjectApp: App {
    @StateObject var taskViewModel = TasksViewModel()
    var body: some Scene {
        WindowGroup {
         RootView()
        }
      
    }
}
