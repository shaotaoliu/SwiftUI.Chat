import Foundation

extension Chat: Decodable {
    enum CodingKeys: String, CodingKey {
        case person
        case messages
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        person = try container.decode(Person.self, forKey: .person)
        messages = try container.decode([Message].self, forKey: .messages)
    }
}

extension Person: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case imgString
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        imgString = try container.decode(String.self, forKey: .imgString)
    }
}

extension Message: Decodable {
    enum CodingKeys: String, CodingKey {
        case text
        case type
        case date
        case alreadyRead
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decode(String.self, forKey: .text)
        alreadyRead = try container.decode(Bool.self, forKey: .alreadyRead)
        
        let value = try container.decode(Int.self, forKey: .type)
        type = value == 0 ? .sent : .received
        
        let seconds = try container.decode(Double.self, forKey: .date)
        date = Date(timeIntervalSinceNow: -seconds)
    }
}
