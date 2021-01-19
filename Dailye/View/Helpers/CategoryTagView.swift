import SwiftUI

struct CategoryTagView: View {
    var category: Categories
    
    var body: some View {
        VStack{
            Text(category.rawValue)
                .cardAccent()
                .padding()
        }
            .cardLook()
    }
}

struct CategoryTagView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            ScrollView (.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Categories.allCases.indices) {index in
                        CategoryTagView(category: Categories.allCases[index])
                    }
                }.padding()
            }
        }
        .preferredColorScheme(.dark)
    }
}
