import Foundation
import MapKit
import CoreLocation

class TopHeadlinesViewModel: ObservableObject{
    @Published var country: Countries
    @Published var language: Languages
    
    init(){
        let defaults = UserDefaults.standard
        let region = Locale.current.regionCode
        country = Countries
            .allCases
            .first(where: {$0.rawValue ==
                defaults.string(forKey: Defaults.country) ??
                region?.lowercased()
            }) ??
            Countries.unitedStates
        language = Languages
            .allCases
            .first(where: {$0.rawValue == defaults.string(forKey: Defaults.language)}) ??
            Languages.english
    }
}
