import SwiftUI

struct MessageBar: View {
    @EnvironmentObject var vm: ChatsViewModel
    @FocusState var focused
    let chat: Chat
    
    var body: some View {
        HStack {
            TextField("Message...", text: $vm.newText, onCommit: {
                vm.sendMessage(in: chat)
            })
                .textFieldStyle(.roundedBorder)
                .submitLabel(.send)
                .focused($focused)
            
            Button(action: {
                vm.sendMessage(in: chat)
            }, label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(7)
                    .background(
                        Circle().foregroundColor(vm.newText.isEmpty ? .gray : .blue)
                    )
            })
                .disabled(vm.newText.isEmpty)
        }
        .padding()
        .background(.thinMaterial)
        .onChange(of: focused) { value in
            if value {
                
            }
        }
    }
}

struct MessageBar_Previews: PreviewProvider {
    static let vm = ChatsViewModel()
    static var previews: some View {
        MessageBar(chat: vm.chats[0])
            .environmentObject(vm)
    }
}
