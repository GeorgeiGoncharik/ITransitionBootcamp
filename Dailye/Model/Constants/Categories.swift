import Foundation
/**
 The category you want to get headlines for.
 Possible options: business entertainment general health science sports technology .
 Note: you can't mix this param with the sources param.
 */
enum Categories: String, CaseIterable {
    case business = "business"
    case entertainment = "entertainment"
    case general = "general"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
}
