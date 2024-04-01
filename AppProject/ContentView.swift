//
//  ContentView.swift
//  AppProject
//
//  Created by Mia Troiano on 2/14/24.
//
import SwiftUI
import UserNotifications

struct ContentView: View {
    @State var showingOptions = false
    @State var showingCal = false
    @State private var OptionsName: String = "Options"
    @State var selectedDate: Date = Date()
    func toggleOptionsName() {
            if OptionsName == "Options" {
                OptionsName = "Home"
            } else {
                OptionsName = "Options"
            }
        }
    var body: some View {
        VStack() {
            Button(OptionsName) {
                self.showingOptions.toggle()
                self.toggleOptionsName()
            }
            .padding(.leading, 275.0)
           // .padding(.top, -35.0)
            .padding(.bottom)
            
            if(showingOptions == true){
                OptionsView()
            }
            else{
                MapView()
               //CalandarView()
            }

        }
        Spacer()
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
