import SwiftUI

struct MessageView: View {
    @EnvironmentObject var vm: ChatsViewModel
    let chat: Chat
    let viewWidth: CGFloat
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: 0) {
            let messageSections = vm.getMessageSections(for: chat)
            
            ForEach(messageSections.indices, id: \.self) { index in
                Section(header: SectionHeader(message: messageSections[index].first!)) {
                    ForEach(messageSections[index]) { message in
                        let receivedMessage = message.type == .received
                        
                        HStack(alignment: .top) {
                            HStack(alignment: .top) {
                                if receivedMessage {
                                    PersonImage(imgString: chat.person.imgString)
                                        .padding(.leading, 10)
                                }
                                
                                Text(message.text)
                                    .padding(12)
                                    .background(receivedMessage ? Color.black.opacity(0.2) : Color.green.opacity(0.9))
                                    .cornerRadius(5)
                                
                                if !receivedMessage {
                                    PersonImage(imgString: "me")
                                        .padding(.trailing, 10)
                                }
                            }
                            // view's wdith - image's width - padding * 2
                            .frame(width: viewWidth - 60, alignment: receivedMessage ? .leading : .trailing)
                            .padding(.vertical, 12)
                        }
                        .frame(maxWidth: .infinity, alignment: receivedMessage ? .leading : .trailing)
                        .id(message.id)          // automatic scrolling later
                    }
                }
            }
        }
    }
    
    struct SectionHeader: View {
        let message: Message
        
        var body: some View {
            Text(message.date.longString())
                .foregroundColor(.gray)
                .font(.system(size: 14))
                .padding(.vertical, 10)
        }
    }
    
    struct PersonImage: View {
        let imgString: String
        
        var body: some View {
            Image(imgString)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static let vm = ChatsViewModel()
    static var previews: some View {
        ScrollView {
            MessageView(chat: vm.chats[0], viewWidth: UIScreen.main.bounds.width)
        }
        .environmentObject(vm)
    }
}
