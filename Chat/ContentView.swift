import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: ChatsViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.searchedChats) { chat in
                    ZStack {
                        ChatRow(chat: chat)
                        
                        // Hide the left arrow
                        NavigationLink(destination: {
                            ChatView(chat: chat)
                        }, label: {
                            EmptyView()
                        })
                            .buttonStyle(.plain)
                            .frame(width: 0)
                            .opacity(0)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive, action: {
                            vm.delete(chat: chat)
                        }, label: {
                            Label("Delete", systemImage: "trash")
                        })
                        
                        if let lastMessage = chat.messages.last, !lastMessage.alreadyRead {
                            Button("Mark as \nRead") {
                                vm.markAsRead(chat: chat)
                            }
                            .tint(.blue)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .searchable(text: $vm.searchText)
            .navigationTitle("Chats")
//            .navigationBarItems(trailing: Button(action: {
//
//            }, label: {
//                Image(systemName: "square.and.pencil")
//            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ChatsViewModel())
    }
}
