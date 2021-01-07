import Foundation
/**
 The order to sort the articles in. Possible options: relevancy, popularity, publishedAt.
 -relevancy = articles more closely related to q come first.
 -popularity = articles from popular sources and publishers come first.
 -publishedAt = newest articles come first.
 Default: publishedAt
 */
enum SortBys: String {
    case relevancy = "relevancy"
    case popularity = "popularity"
    case publishedAt = "publishedAt"
}
