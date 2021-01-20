import SwiftUI

struct CardTextField: View {
    var textField: TextField<Text>
    var imageName: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .cardText()
            textField
                .cardText()
            }
        .padding()
        .cardLook()
        }
}
