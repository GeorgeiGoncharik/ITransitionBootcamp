import Foundation
import MapKit
import CoreLocation

class TopHeadlinesViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var country: Countries?
    
    override init(){
        super.init()
        let region = Locale.current.regionCode
        country = Countries.allCases.first(where: {$0.rawValue == region?.lowercased()}) ?? Countries.unitedStates
    }
    
    private func startLocationTracking(){
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyReduced
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocation = manager.location else { return }
        fetchCountryLocationManager(from: location) {country, error in
            guard let country = country, error == nil else { return }
            self.country = Countries.allCases.first(where: {$0.rawValue == country.lowercased()})
        }
    }
    
    private func fetchCountryLocationManager(from location: CLLocation, completion: @escaping (_ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.isoCountryCode,error)
        }
    }
}
