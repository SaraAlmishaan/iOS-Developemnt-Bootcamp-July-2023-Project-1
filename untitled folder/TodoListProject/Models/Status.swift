import Foundation

enum Status : Int ,Codable {
    case backlog = 1
    case todo = 2
    case inProgress = 3
    case done = 4
    
    
    var name: String {
        switch self {
        case .backlog :
            return "BackLog"
        case .todo :
            return "Todo"
        case .inProgress :
            return "In Progress"
        case .done:
            return "Done"
        }
    }
}
