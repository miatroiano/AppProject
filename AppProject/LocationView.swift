//
//  LocationView.swift
//  AppProject
//
//  Created by Mia Troiano on 4/11/24.
//

import Foundation
import SwiftUI
import MapKit

struct LocationView: View {
    @Binding private var SelectedLocation: SearchResult
    @Binding private var SelectedTitle: SearchResult
    @State private var locationService = LocationService(completer: .init())
    @Binding var searchResults: [SearchResult]
    var body: some View {
        VStack {
           // Text(SelectedTitle.title)
        }
        .padding()
        .interactiveDismissDisabled()
        .presentationDetents([.height(200), .large])
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
    }
    
    
}




