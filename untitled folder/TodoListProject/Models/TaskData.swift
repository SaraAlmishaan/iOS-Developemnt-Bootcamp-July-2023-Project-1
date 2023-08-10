import Foundation

struct  TaskData: Identifiable , Codable {
    var id : UUID = UUID()
    let title : String
    let description : String
    let priority : Priority
    let status : Status
}
