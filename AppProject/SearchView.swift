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
    private let startingPoint = CLLocationCoordinate2D(
            latitude: 40.83657722488077,
            longitude: 14.306896671048852
        )
    @State private var search: String = ""
    @State private var searchInput: String = ""
    @State private var locationService = LocationService(completer: .init())
    @State private var selectedResult: MKMapItem?
    @State private var route: MKRoute?
    @Binding var searchResults: [SearchResult]
    @Binding var selected: Bool
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
            List {
                ForEach(locationService.searchDone) { completion in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(completion.title)
                            .font(.headline)
                            .fontDesign(.rounded)
                        Text(completion.subTitle)
                        Button(action: { }) {
                            if let url = completion.url {
                                Link(url.absoluteString, destination: url)
                                    .lineLimit(1)
                            }
                        }
                        Button("open in maps"){
                            if let opens = completion.placemark {
                                let mapitem = MKMapItem(placemark: opens)
                                selectedResult = mapitem
                                mapitem.openInMaps()
                            }
                        }
//                        Button("get Directions"){
//                            if let opens = completion.placemark {
//                                let mapitemD = MKMapItem(placemark: opens)
//                            }
//                        }
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .interactiveDismissDisabled()
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
    }
}



