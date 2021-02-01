import SwiftUI

struct NoteRow: View {
    @StateObject var note: Note
    
    var body: some View {
        VStack(alignment: .leading){
            Text("\(note.content ?? "")")
            Divider().padding(.horizontal)
            HStack{
                Text("Edited \(note.editDate.withAgo)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                Spacer()
            }
        }
        .padding()
        .cardLook()
    }
}
