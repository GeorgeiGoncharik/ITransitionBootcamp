import Foundation

struct EverythingRequest: Requestable {
    let endpoint = "everything"
    var page: Int = 1
    
    var q: String?
    var sources: [String] = []
    var domains: [String] = []
    var from: Date?
    var to: Date?
    var language: Languages?
    var sortingStrategy: SortBys?
    var pageSize: Int?
    
    var params: String {
        var query: [String] = []
        
        if let q = q{
            query.append("q=" + q)
        }
        
        if sources.count > 0{
            query.append("sources=" + sources.joined(separator: ","))
        }
        
        if domains.count > 0{
            query.append("domains=" + domains.joined(separator: ","))
        }
        
        if let from = from{
            let encoder = iso8601JSONEncoder()
            let data = try! encoder.encode(from)
            query.append("from=" + String(data: data, encoding: .utf8)!)
        }
        
        if let to = to{
            let encoder = iso8601JSONEncoder()
            let data = try! encoder.encode(to)
            query.append("to=" + String(data: data, encoding: .utf8)!)
        }
        
        if let language = language{
            query.append("language=" + language.rawValue)
        }
    
        if let sortingStrategy = sortingStrategy{
            query.append("sortBy=" + sortingStrategy.rawValue)
        }
        
        if let pgSize = pageSize{
            query.append("pageSize=\(pgSize)")
        }
        
        if page > 1 {
            query.append("page=\(page)")
        }
        
        let queryParams = query.joined(separator: "&")
        return queryParams
    }
    
    mutating func nextPage() {
        page += 1
    }
}
