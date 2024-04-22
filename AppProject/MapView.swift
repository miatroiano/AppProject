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
struct MapView: View {
    let manager = CLLocationManager()
    let startingPoint = CLLocationCoordinate2D(
        latitude: 40.83657722488077,
        longitude: 14.306896671048852
    )
    @State var DateTD: Date = Date()
    @State private var searchResults = [SearchResult]()
    @State private var searchInput: String = ""
    @State private var position = MapCameraPosition.automatic
    @State private var selectedLocation: SearchResult?
    @State private var isSheetPresented: Bool = false
    @State private var placemarkName: String?
    @State private var isLocPresented: Bool = false
    @State private var selectedPlacemark: SearchResult?
    @State private var selectedResult: MKMapItem?
    @State private var route: MKRoute?
    
    private var travelTime: String? {
        // Check if there is a route to get the info from
        guard let route else { return nil }// Set up a date formater
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        // Format the travel time to the format you want to display it
        return formatter.string(from: route.expectedTravelTime)
    }
    
    var body: some View {
        VStack{
            Text(Date.now, format: .dateTime.day().month().year().weekday())
                .font(.system(size: 24))
                .bold()
            Text(Date.now, format: .dateTime.hour().minute())
                .font(.system(size: 24))
                .bold()
            SearchView(searchResults: $searchResults, selected: $isSheetPresented)
                .padding([.leading, .bottom])
        }
        ZStack{
            Map(position: $position, selection: $selectedPlacemark){
                UserAnnotation()
                ForEach(searchResults) { result in
                    Group{
                        Marker(coordinate: result.location) {
                            Image(systemName: "mappin")
                        }
                        .tag(result)
                    }.tag(result)
                }
                // Marker("Start", coordinate: self.startingPoint)
                if let route {
                    MapPolyline(route)
                        .stroke(.blue, lineWidth: 5)
                }
            }
        }
        .onAppear{
            manager.requestWhenInUseAuthorization()
        }
        .ignoresSafeArea()
        .onChange(of: selectedPlacemark) {
            isSheetPresented = true
        }
        
        .onChange(of: searchResults) {
            if let firstResult = searchResults.first, searchResults.count == 1 {
                selectedLocation = firstResult
            }
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
    }
//    func getDirections(){
//        if let opens = selectedPlacemark.placemark {
//            let mapitemD = MKMapItem(placemark: opens)
//            route = nil
//            let request = MKDirections.Request()
//            request.source = MKMapItem(placemark: MKPlacemark(coordinate: startingPoint))
//            request.destination = mapitemD
//            Task {
//                let directions = MKDirections(request: request)
//                let response = try? await directions.calculate()
//                route = response?.routes.first
//            }
//        }
//        
//    }
}
#Preview {
    MapView()
}
