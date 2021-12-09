import SwiftUI

struct MessageBar: View {
    @EnvironmentObject var vm: ChatsViewModel
    @State private var text = ""
    
    let chat: Chat
    @Binding var messageId: UUID?
    
    var body: some View {
        HStack {
            TextField("Message...", text: $text, onCommit: {
                sendMessage()
            })
                .textFieldStyle(.roundedBorder)
                .submitLabel(.send)
            
            Button(action: {
                sendMessage()
            }, label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(7)
                    .background(
                        Circle().foregroundColor(text.isEmpty ? .gray : .blue)
                    )
            })
                .disabled(text.isEmpty)
        }
        .padding()
        .background(.thinMaterial)
    }
    
    func sendMessage() {
        if let message = vm.sendMessage(text, in: chat) {
            text = ""
            messageId = message.id
        }
    }
}

struct MessageBar_Previews: PreviewProvider {
    static let vm = ChatsViewModel()
    static var previews: some View {
        MessageBar(chat: vm.chats[0], messageId: .constant(UUID()))
            .environmentObject(vm)
    }
}
