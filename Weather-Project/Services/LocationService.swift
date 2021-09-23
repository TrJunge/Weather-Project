//
//  LocationService.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import CoreLocation

protocol LocationServiceProtocol {
    var mainTabBarDelegate: MainTabBarPresenterProtocol! { get set }
}

class LocationService: NSObject, LocationServiceProtocol {
    fileprivate let locationManager = CLLocationManager()
    weak var mainTabBarDelegate: MainTabBarPresenterProtocol!
    override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
}

// MARK: CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .denied:
            mainTabBarDelegate.failureLocation(failureType: .privacyAuthorization, error: nil)
        default:
            print("Other CLAuthorizationStatus ")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            mainTabBarDelegate.successLocation(coordinate: location.coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        mainTabBarDelegate.failureLocation(failureType: .geolocationConnection, error: error)
    }
}
