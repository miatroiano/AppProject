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
    @State var showingProfile = false
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
            HStack(){
                Button(OptionsName) {
                    self.showingOptions.toggle()
                    self.toggleOptionsName()
                }
                .padding([.leading, .bottom])
                Spacer()
                
            }
            VStack() {
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                    .padding(.all)
                    .datePickerStyle(.graphical)
                
                Text(selectedDate.formatted(date: .abbreviated, time: .shortened))
                    .font(.system(size: 24))
                    .bold()
                    .padding()
                    .animation(.spring(), value: selectedDate)
                    .frame(width: 500)
               //Divider()
            }
            
           
            if(showingOptions == true){OptionsView()}

        }
        Spacer()
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
