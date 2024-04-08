//
//  Searchbar.swift
//  AppProject
//
//  Created by Mia Troiano on 3/4/24.
//

import Foundation
import SwiftUI
import MapKit

struct Searchbar: View {
    @Binding var searchResults: [MKMapItem]
    @State private var searchInput: String = ""
    
    
    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(
            center: .home,
            span: MKCoordinateSpan (latitudeDelta: 0.0125, longitudeDelta: 0.0125)
        )
        
        Task {
            
            
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
    
    var body: some View {
        VStack {
            TextField(
                "Search for a Location",
                text: $searchInput
            )
        }
        .textFieldStyle(.roundedBorder)
        HStack{
            Button{
                search(for: searchInput)
            } label:{
                Label("search", systemImage: "magnifyingglass")
            }
            .buttonStyle(.borderedProminent)
        }
        
    }
}
