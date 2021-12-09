import Foundation

class ChatsViewModel: ObservableObject {
    @Published var chats: [Chat] = []
    @Published var searchText = ""
    @Published var newText = ""
    @Published var scrollMessageId: UUID?
    
    init() {
        load()
    }
    
    func load() {
        guard let file = Bundle.main.url(forResource: "chats", withExtension: "json") else {
            print("File not found.")
            return
        }
        
        do {
            let data = try! Data(contentsOf: file)
            chats = try JSONDecoder().decode([Chat].self, from: data)
        }
        catch {
            print("Decoding failed: \(error)")
        }
    }
    
    var searchedChats: [Chat] {
        let sortedChats = chats.sorted {
            guard let d1 = $0.messages.last?.date else {
                return false
            }
            
            guard let d2 = $1.messages.last?.date else {
                return true
            }
            
            return d1 > d2
        }
        
        if searchText.isEmpty {
            return sortedChats
        }
        
        return sortedChats.filter { $0.person.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    func delete(chat: Chat) {
        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
            chats.remove(at: index)
        }
    }
    
    func markAsRead(chat: Chat) {
        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
            chats[index].markAsRead()
        }
    }
    
    func sendMessage(in chat: Chat) -> Message? {
        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
            var message = Message(newText, type: .sent)
            message.alreadyRead = true
            
            chats[index].messages.append(message)
            scrollMessageId = message.id
            newText = ""
            
            return message
        }
        
        return nil
    }
    
    func getMessageSections(for chat: Chat) -> [[Message]] {
        var sections = [[Message]]()
        var section = [Message]()
        
        for message in chat.messages {
            if let firstMessage = section.first {
                let minutes = minutesBetween(from: firstMessage.date, to: message.date)
                if minutes >= 15 {
                    sections.append(section)
                    section.removeAll()
                }
            }
            
            section.append(message)
        }
        
        sections.append(section)
        return sections
    }
}
