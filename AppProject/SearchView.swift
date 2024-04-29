//
//  SearchView.swift
//  AppProject
//
//  Created by Mia Troiano on 4/3/24.
//

import Foundation
import SwiftUI
import MapKit


struct SearchView: View {
    @State private var search: String = ""
    @State private var searchInput: String = ""
    @State private var locationService = LocationService(completer: .init())
    @Binding var searchResults: [SearchResult]
    @Binding var selected: Bool
    @Binding var showRoute: Bool
    @Binding var travelTime: TimeInterval?
    @Binding var selectedPlacemark: SearchResult?
    var travelTimes: String? {
        guard let travelTime else { return nil }
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        return formatter.string(from: travelTime)
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $searchInput)
                    .autocorrectionDisabled()
                    .onSubmit {
                        Task {
                            searchResults = (try? await locationService.search(with: searchInput)) ?? []
                        }
                    }
            }
        }
        .onChange(of: searchInput) {
            locationService.update(queryFragment: searchInput)
        }
        .sheet(isPresented: $selected) {
            if let placemark = selectedPlacemark {
                VStack {
                    Text(placemark.name)
                        .font(.headline)
                        .fontDesign(.rounded)
                    Text(placemark.subTitle)
                        .font(.headline)
                        .fontDesign(.rounded)
                    Text("Location: \(placemark.location.latitude), \(placemark.location.longitude)")
                    Button("Show Route") {
                        showRoute.toggle()
                    }
                    if let travelTimes {
                        Text(" time: \(travelTimes)")
                            .font(.headline)
                            .fontDesign(.rounded)
                    }
                    Button("open in maps"){
                        if let opens = placemark.placemark {
                            let mapitem = MKMapItem(placemark: opens)
                            mapitem.openInMaps()
                        }
                    }
                }
                .presentationDetents([.height(300)])
            }
        }
        .interactiveDismissDisabled()
    }
}
