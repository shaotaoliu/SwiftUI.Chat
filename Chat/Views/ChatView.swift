import SwiftUI

struct ChatView: View {
    @EnvironmentObject var vm: ChatsViewModel
    let chat: Chat
    @State var text = ""
    @State var scrollMessageId: UUID?
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                ScrollView {
                    ScrollViewReader { reader in
                        MessageView(chat: chat, viewWidth: geometry.size.width)
                            .onChange(of: scrollMessageId) { _ in
                                if let messageId = scrollMessageId {
                                    scrollTo(scrollReader: reader, messageId: messageId, shouldAnimate: true)
                                }
                            }
                            .onAppear {
                                if let messageId = chat.messages.last?.id {
                                    scrollTo(scrollReader: reader, messageId: messageId, shouldAnimate: false)
                                }
                            }
                    }
                }
            }
            .padding(.bottom, 5)
            
            MessageBar(chat: chat, messageId: $scrollMessageId)
        }
        .navigationTitle(chat.person.name)
        .navigationBarTitleDisplayMode(.inline)
        //.navigationBarItems(trailing: TrailingButton)
        .onAppear {
            vm.markAsRead(chat: chat)
        }
    }
    
    func scrollTo(scrollReader: ScrollViewProxy, messageId: UUID, shouldAnimate: Bool) {
        DispatchQueue.main.async {
            withAnimation(shouldAnimate ? .easeIn : nil) {
                scrollReader.scrollTo(messageId, anchor: .bottom)
            }
        }
    }
    
    var TrailingButton: some View {
        HStack {
            Button(action: {
                
            }, label: {
                Image(systemName: "video")
            })
            
            Button(action: {
                
            }, label: {
                Image(systemName: "phone")
            })
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static let vm = ChatsViewModel()
    static var previews: some View {
        NavigationView {
            ChatView(chat: vm.chats[0])
                .environmentObject(vm)
        }
    }
}
