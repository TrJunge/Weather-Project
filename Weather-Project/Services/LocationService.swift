//
//  LocationService.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import Foundation
import CoreLocation
import UIKit

protocol LocationServiceProtocol {
    var coordinate: CLLocationCoordinate2D! { get set }
    var cardinalPoints: String? { get set }
}

class LocationService: NSObject, LocationServiceProtocol {
    fileprivate let locationManager = CLLocationManager()
    var coordinate: CLLocationCoordinate2D!
    var cardinalPoints: String?
    
    override init() {
        super.init()
        setLocationManager()
    }
    
    private func setLocationManager() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingHeading()
        self.locationManager.startUpdatingLocation()
    }
    
    private func compassDirection(for heading: CLLocationDirection) -> String? {
        guard heading > 0 else {
            return nil
        }
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
        let index = Int((heading + 22.5) / 45.0) & 7
        return directions[index]
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            coordinate = location.coordinate
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        guard let direction = compassDirection(for: newHeading.trueHeading) else { return }
        cardinalPoints = direction
        locationManager.stopUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get users location.")
    }
}
