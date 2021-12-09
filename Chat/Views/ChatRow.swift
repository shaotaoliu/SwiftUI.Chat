import SwiftUI

struct ChatRow: View {
    let chat: Chat
    
    var body: some View {
        HStack(spacing: 20) {
            Image(chat.person.imgString)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(chat.person.name)
                        .bold()
                    
                    Spacer()
                    
                    Text(chat.messages.last?.date.shortString() ?? "")
                        .font(.system(size: 14))
                }
                
                HStack() {
                    Text(chat.messages.last?.text ?? "")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    let count = chat.unreadMessagesCount
                    
                    if count > 0 {
                        Text("\(count)")
                            .font(.system(size: 12).bold())
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 2)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                }
            }
        }
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(chat: ChatsViewModel().chats[0])
    }
}
