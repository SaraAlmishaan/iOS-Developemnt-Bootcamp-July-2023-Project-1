import SwiftUI
import Foundation

class TasksViewModel : ObservableObject {
    @AppStorage ("TaskData0") var task = [TaskData]()
    @AppStorage ("title1") var title : String = ""
    @AppStorage ("description2") var description : String = ""


// MARK:  Adding Task Function
    func addNewTask(iTitle : String, iDescription : String, iPriority : Int, iStatus : Int) {
        var inputPriority : Priority
             switch iPriority {
                case 1 : inputPriority  = .low
                case 2 : inputPriority  = .medium
                case 3 : inputPriority  = .high
               default:
                  inputPriority  = .low
               }
     
         var inputStatus : Status
            switch iStatus  {
                case 1 : inputStatus = .backlog
                case 2 : inputStatus = .todo
                case 3 : inputStatus = .inProgress
                case 4 : inputStatus = .done
               default:
                 inputStatus = .done
             }
     
          task.append(
                TaskData(
                    title: iTitle,
                    description: iDescription,
                    priority: inputPriority,
                    status: inputStatus
                  )
                )
     }

// MARK:  Editing Task Function
  func editTask(iTitle: String, iDescription: String, iPriority: Int, iStatus: Int,  iTaskId : UUID){
      var inputPriority : Priority
         switch iPriority {
            case 1 : inputPriority  = .low
            case 2 : inputPriority  = .medium
            case 3 : inputPriority  = .high
           default:
              inputPriority  = .low
           }

      var inputStatus : Status
        switch iStatus  {
            case 1 : inputStatus = .backlog
            case 2 : inputStatus = .todo
            case 3 : inputStatus = .inProgress
            case 4 : inputStatus = .done
           default:
             inputStatus = .done
         }
      
        task.indices.forEach{
            index in
            if task[index].id ==  iTaskId {
                task[index] =
                    TaskData (
                        title : iTitle,
                        description: iDescription,
                        priority: inputPriority,
                        status: inputStatus
                )
            }
        }
  }
// MARK:  Deleting Task Function
    func deleteTask(removeTask : TaskData ) {
         task = task.filter({
            taskIndex in
              taskIndex.id != removeTask.id
             }
           )
    }
}


  

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8) else {
            return nil
        }
        do {
            let result = try JSONDecoder().decode([Element].self, from: data)
            print("Init from result: \(result)")
            self = result
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        print("Returning \(result)")
        return result
    }
}
