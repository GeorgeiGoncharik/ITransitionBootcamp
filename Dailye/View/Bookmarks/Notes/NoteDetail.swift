import SwiftUI

struct NoteDetail: View {
    @Environment(\.presentationMode) var presentation
    @StateObject private var viewModel: NoteDetailViewModel
    
    init(note: Note) {
        _viewModel = StateObject(wrappedValue: NoteDetailViewModel(note: note))
    }
    
    var body: some View {
        VStack{
            TextEditor(text: Binding($viewModel.note.content, replacingNilWith: ""))
                .frame(height: 100, alignment: .leading)
                .padding()
                .cardLook()
            HStack{
                Text("Edited \(viewModel.note.editDate.withAgo)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                    .padding()
                Spacer()
                Button(action: {
                    presentation.wrappedValue.dismiss()
                    viewModel.deletePressed()
                }){
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .padding()
                        .cardLook()
                }
                Button(action: {
                    presentation.wrappedValue.dismiss()
                    viewModel.savePressed()
                }){
                    HStack{
                        Text("Save")
                            .cardText()
                        Image(systemName: "checkmark")
                    }
                    .padding()
                    .cardLook()
                }
            }.padding([.top, .horizontal])
        }
        .navigationTitle(viewModel.note.content ?? "Add a new note")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}
