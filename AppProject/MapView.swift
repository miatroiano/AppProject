//
//  MapView.swift
//  AppProject
//
//  Created by Mia Troiano on 2/26/24.
//

import Foundation
import SwiftUI
import UserNotifications
import MapKit

struct MapView: View {
    @State private var searchResults: [MKMapItem] = []
    @State private var searchInput: String = ""
    
    func search(for querey: String){
        let request = MKLocalSearch.Request()
        request.resultTypes = .pointOfInterest
        //result.region = MKCoordinateRegion()
        
        Task{
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
        Map{
            ForEach(searchResults, id: \.self)
            {result in Marker(item: result)}
        }
        
    
    }
    
}

#Preview {
    MapView()
}
