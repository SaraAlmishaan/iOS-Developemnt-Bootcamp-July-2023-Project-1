import SwiftUI

struct RootView: View {
  @StateObject var tViewModel = TasksViewModel()
    var body: some View {
        NavigationView {
            TasksExploreView(tasksViewModel : tViewModel)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
