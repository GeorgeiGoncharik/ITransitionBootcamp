import SwiftUI

struct MainButton: View {

    var imageName: String
    var color: Color

    var width: CGFloat = 50

    var body: some View {
        VStack{
            Image(systemName: imageName)
                .cardAccent()
        }
        .frame(width: width, height: width)
        .cardLook()
    }
}

struct MainButton_Previews: PreviewProvider {
    static var previews: some View {
        MainButton(imageName: "ellipsis", color: .accentColor)
            .preferredColorScheme(.light)
    }
}
