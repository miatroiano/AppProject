//
//  LocationService.swift
//  AppProject
//
//  Created by Mia Troiano on 4/3/24.
//

import Foundation
import MapKit

struct SearchCompletions: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let subTitle: String
    let placemark: MKPlacemark?
    var url: URL?
}
struct SearchResult: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let subTitle: String
    let placemark: MKPlacemark?
    let location: CLLocationCoordinate2D
    static func == (lhs: SearchResult, rhs: SearchResult) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
@Observable
class LocationService: NSObject, MKLocalSearchCompleterDelegate {
    private let completer: MKLocalSearchCompleter
    var searchDone = [SearchCompletions]()
    init(completer: MKLocalSearchCompleter) {
        self.completer = completer
        super.init()
        self.completer.delegate = self
    }
    func update(queryFragment: String) {
        completer.resultTypes = .pointOfInterest
        completer.queryFragment = queryFragment
    }
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchDone = completer.results.map { completion in
                    // Get the private _mapItem property
                    let mapItem = completion.value(forKey: "_mapItem") as? MKMapItem

                    return .init(
                        title: completion.title,
                        subTitle: completion.subtitle,
                        placemark: mapItem?.placemark,
                        url: mapItem?.url
                    )
                }
    }
    func search(with query: String, coordinate: CLLocationCoordinate2D? = nil) async throws -> [SearchResult] {
            let mapKitRequest = MKLocalSearch.Request()
            mapKitRequest.naturalLanguageQuery = query
            mapKitRequest.resultTypes = .pointOfInterest
            if let coordinate {
                mapKitRequest.region = .init(.init(origin: .init(coordinate), size: .init(width: 1, height: 1)))
            }
            let search = MKLocalSearch(request: mapKitRequest)
            let response = try await search.start()
            return response.mapItems.compactMap { mapItem in
                guard let location = mapItem.placemark.location?.coordinate else { return nil }
                let name = mapItem.name ?? "Unknown"
                let subTitle = mapItem.placemark.locality ?? "Unknown"
                let placemark = mapItem.placemark
                return .init(name: name, subTitle: subTitle,placemark: placemark,location: location)
            }
        }
}
