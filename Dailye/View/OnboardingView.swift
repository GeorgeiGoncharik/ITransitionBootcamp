import SwiftUI

struct OnboardingView: View {
    var image: String
    var title: String
    var desc: String
    
    var body: some View {
        VStack(alignment: .center){
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 200.0,height:200)
            Divider()
                .padding()
            Text(title)
                .font(.title)
                .bold()
                .padding(.bottom)
            Text(desc)
                .font(.subheadline)
        }.padding()
    }
}
