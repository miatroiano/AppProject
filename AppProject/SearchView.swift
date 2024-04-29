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
                                mapitem.openInMaps()
                            }
                        }
                        Button("show route"){
                            showRoute.toggle()
                        }
                        
                    }
                    
                }
                
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        
        //.padding()
        .interactiveDismissDisabled()
        // .presentationDetents([.height(200), .large])
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
    }
    
    
}



