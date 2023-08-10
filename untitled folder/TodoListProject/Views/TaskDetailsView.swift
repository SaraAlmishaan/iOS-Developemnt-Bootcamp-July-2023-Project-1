import SwiftUI

struct TaskDetailsView: View {
    @ObservedObject  var tkViewModel : TasksViewModel
    @State private var shouldPresentSheet = false
    @State var taskDetails : TaskData
    @State var titleEditor : String = ""
    @State var descriptionEditor  : String = ""
    @State var priorityEditor = 1
    @State var statusEditor = 1
    
 var body: some View {
      VStack {
          // MARK: Task Details
        Section("Title"){
          Text(taskDetails.title).foregroundColor(Color.black)
          }
        Section("description"){
          Text(taskDetails.description).foregroundColor(Color.black)
          }
        Section("priority"){
          Text(taskDetails.priority.name).foregroundColor(Color.black)
          }
        Section("Status"){
          Text(taskDetails.status.name).foregroundColor(Color.black)
          }
          // MARK: Delete Task
        Button(
            action: {
                tkViewModel.deleteTask(removeTask: taskDetails)
           },
             label: {
               Text("Delete")
            }
           )
          
         Button(
           action: {
               shouldPresentSheet.toggle()
         },
           label : {
             Text("Edit")
             }
       ).sheet(isPresented : $shouldPresentSheet) {
              
         VStack{
            Button(
                action: {
                    shouldPresentSheet.toggle()
                },
                  label: {
                    Text("back")
                        .padding(.vertical, 8)
                        .padding(.horizontal, 4)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(12)
                         }
                     )
                       TextEditor( text : $titleEditor).foregroundColor(Color.black)
                       TextEditor( text : $descriptionEditor).foregroundColor(Color.black)
                  HStack{
                      Picker(
                        selection: $priorityEditor ,
                        label: Text("Priority" )){
                           Text("Low").tag(1)
                           Text("Medium").tag(2)
                           Text("High").tag(3)
                         }
                          .pickerStyle(.menu)
                          .padding(.vertical, 8)
                          .padding(.horizontal, 8)
                          .background(Color.gray.opacity(0.3))
                          .foregroundColor(Color.black)
                          .cornerRadius(12)
                      
                        Picker(
                            selection: $statusEditor ,
                            label: Text("Status")) {
                              Text("BackLog").tag(1)
                              Text("Todo").tag(2)
                              Text("In Progress").tag(3)
                              Text("Done").tag(4)
                              }
                              .pickerStyle(.menu)
                              .padding(.vertical, 8)
                              .padding(.horizontal, 8)
                              .background(Color.gray.opacity(0.3))
                              .foregroundColor(Color.black)
                              .cornerRadius(12)
                        }
                          Button(  //Send the input to the ViewModel
                              action: {
                               tkViewModel.editTask(
                                   iTitle: titleEditor,
                                   iDescription: descriptionEditor,
                                   iPriority: priorityEditor,
                                   iStatus: statusEditor,
                                   iTaskId : taskDetails.id
                                   )
                               }, label : {
                                   Text("Save")
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .background(Color.gray.opacity(0.3))
                                    .foregroundColor(Color.black)
                                    .cornerRadius(12)
                                }
                             )
                          }
                     }
          
            
    }
    .onAppear{
        prepare()
      }
        
  }//body
    func prepare(){
        titleEditor = taskDetails.title
        descriptionEditor   = taskDetails.description
        priorityEditor = taskDetails.priority.rawValue
        statusEditor = taskDetails.status.rawValue
    }
}//View
             





