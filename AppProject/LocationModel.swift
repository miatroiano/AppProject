//
//  LocationModel.swift
//  AppProject
//
//  Created by Mia Troiano on 4/3/24.
//

import Foundation
import SwiftUI
import MapKit

class LocationModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    private var locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationStatus = manager.authorizationStatus
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
//class LocationModel: NSObject, ObservableObject {
//    private let locationManager = CLLocationManager()
//    @Published var authorisationStatus: CLAuthorizationStatus = .notDetermined
//
//    override init() {
//        super.init()
//        self.locationManager.delegate = self
//    }
//
//    public func requestAuthorisation(always: Bool = false) {
//        if always {
//            self.locationManager.requestAlwaysAuthorization()
//        } else {
//            self.locationManager.requestWhenInUseAuthorization()
//        }
//    }
//}
//
//extension LocationModel: CLLocationManagerDelegate {
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        self.authorisationStatus = status
//    }
//}
