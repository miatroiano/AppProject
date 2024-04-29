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
    @State private var showRoute = false
    @State private var routeDisplayed = false
    @State private var route: MKRoute?
    @State private var routeDestination: MKMapItem?
    @State private var travelTime: TimeInterval?
    @State private var timeEst: TimeInterval = 0
    @State private var transportType = MKDirectionsTransportType.automobile
    
    var body: some View {
        VStack{
            Text(Date.now, format: .dateTime.day().month().year().weekday())
                .font(.system(size: 24))
                .bold()
            Text(Date.now, format: .dateTime.hour().minute())
                .font(.system(size: 24))
                .bold()
            TimerView()
            SearchView(searchResults: $searchResults, selected: $isSheetPresented, showRoute: $showRoute)
                .padding([.leading, .bottom])
            //Text(timeEst.formatted())
//            if routeDisplayed{
//                Button("clear route"){
//                    removeRoute()
//                }
//            }
        }
        ZStack{
            Map(position: $position,bounds: nil, interactionModes: .all, selection: $selectedPlacemark, scope: nil)
            {
                UserAnnotation()
                ForEach(searchResults) { result in
                    if !showRoute {
                        Group{
                            Marker(coordinate: result.location) {
                                Image(systemName: "mappin")
                            }
                            .tag(result)
                        }.tag(result)
                    }
                    else{
                        if let routeDestination{
                            Marker(item: routeDestination)
                                .tint(.green)
                        }
                    }
                }
                if let route, routeDisplayed{
                    MapPolyline(route.polyline)
                        .stroke(.blue, lineWidth: 6)
                    //timeEst = travelTime
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
            .task(id: selectedPlacemark) {
                if selectedPlacemark != nil {
                    routeDisplayed = false
                    showRoute = false
                    route = nil
                    await fetchRoute()
                }
            }
            .onChange(of: showRoute) {
                selectedPlacemark = nil
                if showRoute {
                    withAnimation {
                        routeDisplayed = true
                        if let rect = route?.polyline.boundingMapRect {
                            position = .rect(rect)
                        }
                    }
                }
            }
            .task(id: transportType) {
                await fetchRoute()
            }
        }
    }
    
    func updateCameraPosition() {
           if let userLocation = manager.location {
               let userRegion = MKCoordinateRegion(
                   center: userLocation.coordinate,
                   span: MKCoordinateSpan(
                       latitudeDelta: 0.15,
                       longitudeDelta: 0.15
                   )
               )
               withAnimation {
                   position = .region(userRegion)
               }
           }
       }
    func fetchRoute() async {
        if let userLocation = manager.location, let selectedPlacemark {
            let request = MKDirections.Request()
            let sourcePlacemark = MKPlacemark(coordinate: userLocation.coordinate)
            let routeSource = MKMapItem(placemark: sourcePlacemark)
            let destinatinPlacemark = MKPlacemark(coordinate: selectedPlacemark.location)
            routeDestination = MKMapItem(placemark: destinatinPlacemark)
            routeDestination?.name = selectedPlacemark.name
            request.source = routeSource
            request.destination = routeDestination
            request.transportType = transportType
            let directions = MKDirections(request: request)
            let result = try? await directions.calculate()
            route = result?.routes.first
            travelTime = route?.expectedTravelTime
        }
    }
    func removeRoute() {
            routeDisplayed = false
            showRoute = false
            route = nil
            selectedPlacemark = nil
            updateCameraPosition()
        }
}
#Preview {
    MapView()
}
