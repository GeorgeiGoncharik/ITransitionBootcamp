import Foundation
/**
 The 2-letter ISO-639-1 code of the language you want to get headlines for.
 Possible options: ar de en es fr he it nl no pt ru se ud zh. Default: all languages returned.
 */
enum Languages: String, CaseIterable {
    case arabic = "ar"
    case german = "de"
    case english = "en"
    case spanish = "es"
    case french = "fr"
    case hebrew = "he"
    case italian = "it"
    case dutch = "nl"
    case norwegian = "no"
    case portuguese = "pt"
    case russian = "ru"
    case sami = "se"
    case chinese = "zh"
}
