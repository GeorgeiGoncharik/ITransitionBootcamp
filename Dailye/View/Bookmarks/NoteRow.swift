import SwiftUI

struct NoteRow: View {
    @StateObject var note: Note
    
    var body: some View {
        VStack{
            Text("\(note.content ?? "")")
                .frame(height: 100, alignment: .leading)
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
