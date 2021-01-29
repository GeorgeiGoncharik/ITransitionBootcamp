import SwiftUI

struct IconAndTextButton: View {

    var imageName: String
    var buttonText: String

    var body: some View {
            HStack {
                Image(systemName: imageName)
                    .cardAccent()
                Spacer()
                Text(buttonText)
                    .font(.subheadline)
                    .cardText()
                Spacer()
            }
            .padding(.horizontal, 15)
            .frame(width: 170, height: 45)
            .cardLook()
    }
}

struct IconAndTextButton_Previews: PreviewProvider {
    static var previews: some View {
        IconAndTextButton(
            imageName: "square.and.arrow.up",
            buttonText: "Share article"
        )
        .preferredColorScheme(.dark)
    }
}
