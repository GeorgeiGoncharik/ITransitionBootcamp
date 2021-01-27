import Foundation

class SettingsViewModel: ObservableObject{
    @Published var selectedCountry: Countries{
        willSet{
            defaults.set(newValue.rawValue, forKey: Defaults.country)
        }
    }
    @Published var selectedLanguage: Languages{
        willSet{
            defaults.set(newValue.rawValue, forKey: Defaults.language)
        }
    }
    private var defaults: UserDefaults
    let countries = Countries.allCases
    let languages = Languages.allCases
    
    init() {
        defaults = UserDefaults.standard
        let defaultCountry = defaults.string(forKey: Defaults.country)
        let defaultLanguage = defaults.string(forKey: Defaults.language)
        selectedCountry = Countries
            .allCases
            .first(where: {$0.rawValue ==
                    defaultCountry?.lowercased() ??
                    Locale.current.regionCode?.lowercased()}) ??
            Countries.unitedStates
        selectedLanguage = Languages
            .allCases
            .first(where: {$0.rawValue == defaultLanguage?.lowercased()})
            ?? Languages.english
    }
}
