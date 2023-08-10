import SwiftUI

struct AddNewTaskView: View {
  @ObservedObject var taskViewModel : TasksViewModel
  @Binding var isPresented : Bool
  @State var titleField : String = ""
  @State var descriptionField  : String = ""
  @State var priorityFiled = 1
  @State var statusFiled = 1
    
    var body: some View {
      VStack{
            HStack{
                 Button(
                    action: {
                        isPresented = false
                        print("adddddddd")
                        print(isPresented )
                   },
                     label: {
                      Text("Cancel")
                    }
                  )
                  Spacer()
                  Button(
                      action: {
                        taskViewModel.addNewTask(
                            iTitle: titleField ,
                            iDescription: descriptionField,
                            iPriority: priorityFiled,
                            iStatus: statusFiled
                           )
                     },
                      label : {
                             Text("Add")
                            }
                        )
               }.padding(11)
           
          TextField("Title", text:  $titleField )
                 .frame(height: 40)
              TextField( "description", text: $descriptionField)
                  frame(height: 40)
            HStack{
              Picker(selection: $priorityFiled , label: Text("Priority")) {
                 Text("Low").tag(1)
                 Text("Medium").tag(2)
                 Text("High").tag(3)
                 }
                  .padding(.vertical, 8)
                  .padding(.horizontal, 16)
                  .background(Color.gray.opacity(0.3))
                  .foregroundColor(Color.black)
                  .cornerRadius(12)
   
                    Spacer()
                 Picker(selection: $statusFiled , label: Text("Status")) {
                   Text("BackLog").tag(1)
                   Text("Todo").tag(2)
                   Text("In Progress").tag(3)
                   Text("Done").tag(4)
                   }
                     .padding(.vertical, 8)
                     .padding(.horizontal, 16)
                     .background(Color.gray.opacity(0.3))
                     .foregroundColor(Color.black)
                     .cornerRadius(12)
                }
      }.border(Color.red)
  }//body
}//view






 

