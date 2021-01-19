import SwiftUI

struct TitleWithSF: View {
    var sf: String
    var title: String
    var style: Font.TextStyle
    
    init(sf: String, _ title: String, _ style: Font.TextStyle = .headline) {
        self.sf = sf
        self.title = title
        self.style = style
    }
    
    var body: some View {
        HStack{
            Image(systemName: sf)
                .padding(.trailing, 0)
            Text(title)
                .autocapitalization(.allCharacters)
        }
            .font(Font.system(style))
    }
}

struct TitleWithSF_Previews: PreviewProvider {
    static var previews: some View {
        TitleWithSF(sf: "clock", "top headlines")
    }
}
