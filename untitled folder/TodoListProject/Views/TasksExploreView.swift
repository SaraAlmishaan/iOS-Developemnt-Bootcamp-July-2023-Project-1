import SwiftUI

struct TasksExploreView : View {
  @ObservedObject  var tasksViewModel : TasksViewModel
  @State var filters : Array<TaskData> = []
  @State var shouldPresentSheet = false
  @State var searchedText : String = ""
  @State var statusFiled = 0
    
    var backlogTask : Array<TaskData> {
        tasksViewModel.task.filter({
            task in
            task.status == .backlog
        }
       )
    }
    var todoTask : Array<TaskData> {
        tasksViewModel.task.filter({
            task in
            task.status == .todo
        }
      )
    }
    var inProgressTask : Array<TaskData> {
        tasksViewModel.task.filter({
            task in
            task.status == .inProgress
         }
       )
     }
    var doneTask : Array<TaskData> {
        tasksViewModel.task.filter({
            task in
            task.status == .done
         }
       )
     }

    var body: some View {
       VStack{
           // MARK: Search Box
             HStack {
                 Image(systemName: "magnifyingglass")
                      .padding(.horizontal, 16)
                 TextField( "Search", text: $searchedText)
                     .frame( height: 55)
               }
                 .background(Color.gray.opacity(0.2))
                 .cornerRadius(13)
            // MARK: View List
               List {
                   ForEach(tasksViewModel.task){
                   task in
                     NavigationLink(
                         destination: {
                             TaskDetailsView(
                                tkViewModel : tasksViewModel,
                                 taskDetails : task
                                )
                          },
                            label: {
                                Text(task.title)
                           }
                        )
                   }
                     .onMove {
                        indexSet, offset in
                       tasksViewModel.task.move(fromOffsets: indexSet, toOffset: offset)
                     }
                     .onDelete {
                         indexSet in
                        tasksViewModel.task.remove(atOffsets: indexSet)
                      }
              } // MARK:  Filter, Edit, Add buttons
               .toolbar {
                    HStack{
                         Picker("Filter", selection: $statusFiled ) {
                           Text("All Tasks").tag(0)
                           Text("BackLog Tasks").tag(1)
                           Text("Todo Tasks").tag(2)
                           Text("In-Progress Tasks").tag(3)
                           Text("Done Tasks").tag(4)
                          }
                           .pickerStyle(.menu)
                        EditButton()
                        Button(
                            action: {
                                shouldPresentSheet.toggle()
                            },
                              label: {
                                  Image(systemName: "plus.circle").foregroundColor(Color.blue)
                             }
                          ) .sheet(isPresented : $shouldPresentSheet) {
                               AddNewTaskView(
                                    taskViewModel : tasksViewModel,
                                    isPresented : $shouldPresentSheet
                                 )
                               }
                        }
                     }
           
           


     }.frame(height: 750)
       .onAppear{
         prepare()
          }
      .onChange(of: searchedText ){ value in
         filtersUpdate(value)
      }
      .onChange(of: statusFiled  ){ value in
         filtersSwitch(value)
      }
            
  }//body
    
func filtersSwitch(_ statusFiled : Int){
    switch statusFiled {
    case 1 :
         filters = backlogTask
    case 2 :
        filters = todoTask
    case 3:
        filters = inProgressTask
    case 4:
        filters = doneTask
    default:
        filters = tasksViewModel.task
       }
    }
    
  func prepare(){
        filters = tasksViewModel.task
    }
    
 func filtersUpdate( _ value : String ){
        if value.isEmpty {
            filters = tasksViewModel.task
        }else{
            let valueLowerCased = value.lowercased()
            filters = tasksViewModel.task.filter({
                task in
                return task.title.lowercased().contains(valueLowerCased)
               }
            )
        }
   }
}//view






