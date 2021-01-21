import SwiftUI

struct SearchView: View {
    @State var search = ""
    
    var body: some View {
        NavigationView{
            VStack{
                CardTextField(
                    textField: TextField("", text: $search),
                    imageName: "magnifyingglass"
                )
                .padding()
                
                ArticleList(request: EverythingRequest(q:search))
            }
            .navigationTitle("Search")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
