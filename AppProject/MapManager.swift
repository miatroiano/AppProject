//
//  MapManager.swift
//  AppProject
//
//  Created by Mia Troiano on 4/17/24.
//

import Foundation
import MapKit
import SwiftData

enum MapManager {
    @MainActor
    static func searchPlaces(_ modelContext: ModelContext, searchText: String) async {
        removeSearchResults(modelContext)
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
       
        let searchItems = try? await MKLocalSearch(request: request).start()
        let results = searchItems?.mapItems ?? []
        results.forEach {
            let mtPlacemark = MTPlacemark(
                name: $0.placemark.name ?? "",
                address: $0.placemark.title ?? "",
                latitude: $0.placemark.coordinate.latitude,
                longitude: $0.placemark.coordinate.longitude
            )
            modelContext.insert(mtPlacemark)
        }
    }
    
    static func removeSearchResults(_ modelContext: ModelContext) {
        
        try? modelContext.delete(model: MTPlacemark.self)
    }
}
