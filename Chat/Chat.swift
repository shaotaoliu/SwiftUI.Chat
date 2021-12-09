import Foundation

struct Chat: Identifiable {
    var id: UUID {
        person.id
    }
    
    let person: Person
    var messages: [Message]
    var hasUnreadMessage = false
    
    var unreadMessagesCount: Int {
        messages.filter { !$0.alreadyRead } .count
    }
    
    mutating func markAsRead() {
        for i in 0..<messages.count {
            messages[i].alreadyRead = true
        }
    }
}

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let imgString: String
}

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let type: MessageType
    let date: Date
    var alreadyRead: Bool = false
    
    init(_ text: String, type: MessageType, date: Date = Date()) {
        self.text = text
        self.type = type
        self.date = date
    }
    
    enum MessageType {
        case sent
        case received
    }
}
