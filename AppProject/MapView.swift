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

extension CLLocationCoordinate2D{
    static let home = CLLocationCoordinate2D(latitude: 41.308273, longitude: -72.927887)
    static let school = CLLocationCoordinate2D(latitude: 41.421440, longitude: -72.894005)
}

struct MapView: View {
    @State private var searchResults: [MKMapItem] = []
    @State private var searchInput: String = ""
    @State var region = MapCameraPosition.region(MKCoordinateRegion(
        center: .home,
        span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2))
    )
    func search(for querey: String){
        let request = MKLocalSearch.Request()
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(center: .home, span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125) )
        
        Task{
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
    }
    
    
    var body: some View {
        Map(
            position: $region,bounds: nil, interactionModes: .all, scope: nil
        ){
            
            ForEach(searchResults, id: \.self)
            {result in Marker(item: result)}
        }
        
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
        
        HStack{
            Spacer()
            Searchbar(searchResults: $searchResults)
                .padding(.top)
        }
        
    }
    
}

#Preview {
    MapView()
}
