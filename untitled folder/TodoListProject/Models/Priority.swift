import Foundation

enum Priority : Int ,Codable {

    case low = 1
    case medium = 2
    case high = 3
    
    var name: String {
        switch self {
        case .low :
            return "Low"
        case .medium :
            return "Medium"
        case .high :
            return "High"
        }
    }
}
