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
import SwiftData

extension CLLocationCoordinate2D{
    static let home = CLLocationCoordinate2D(latitude: 41.308273, longitude: -72.927887)
}
struct MapView: View {
    let manager = CLLocationManager()
    @State var DateTD: Date = Date()
    @State private var searchResults = [SearchResult]()
    @State private var searchInput: String = ""
    @State private var position = MapCameraPosition.automatic
    @State private var selectedLocation: SearchResult?
    @State private var isSheetPresented: Bool = false
    @State private var isLocPresented: Bool = false
    @State private var region = MapCameraPosition.region(MKCoordinateRegion(
        center: .home,
        span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2))
    )
    @State private var selectedPlacemark: SearchResult?

    var body: some View {
        VStack{
            Text(Date.now, format: .dateTime.day().month().year().weekday())
                .font(.system(size: 24))
                .bold()
            Text(Date.now, format: .dateTime.hour().minute())
                .font(.system(size: 24))
                .bold()
            TimerView()
            SearchView(searchResults: $searchResults, selected: $isSheetPresented)
                .padding([.leading, .bottom])
        }
        ZStack{
            Map(position: $position,bounds: nil, interactionModes: .all, selection: $selectedPlacemark, scope: nil)
            {
                UserAnnotation()
                ForEach(searchResults) { result in
                    Group{
                        Marker(coordinate: result.location) {
                            Image(systemName: "mappin")
                        }
                        .tag(result)
                    }.tag(result)
                    
                }
               
                
            }
            .onAppear{
                manager.requestWhenInUseAuthorization()
            }
            .ignoresSafeArea()
            .onChange(of: selectedPlacemark) {
                isSheetPresented = true
                
                
            }
//            .onChange(of: selectedPlacemark) {
//                isLocPresented = true
//            }
            .onChange(of: searchResults) {
                if let firstResult = searchResults.first, searchResults.count == 1 {
                    selectedLocation = firstResult
                }
            }
//            .sheet(isPresented: $isSheetPresented) {
//                SearchView(searchResults: $searchResults)
//            }
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
        }
    }
}
#Preview {
    MapView()
}
