import Foundation

struct TopHeadlinesRequest: Requestable {
    
    let endpoint = "top-headlines"
    
    var q: String?
    var sources: [String] = []
    var category: Categories?
    var language: Languages?
    var country: Countries?
    var pageSize: Int?
    
    func makeQueryParams() -> String {
        var query: [String] = []
        
        if let q = q{
            query.append("q=" + q)
        }
        
        if sources.count > 0{
            query.append("sources=" + sources.joined(separator: ","))
        }
        
        if let category = category{
            query.append("category=" + category.rawValue)
        }
        
        if let language = language{
            query.append("language=" + language.rawValue)
        }
        
        if let country = country{
            query.append("country=" + country.rawValue)
        }
        
        if let pgSize = pageSize{
            query.append("pageSize=\(pgSize)")
        }
        
        let queryParams = query.joined(separator: "&")
        return queryParams
    }
}
