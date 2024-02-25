//
//  CalandarView.swift
//  AppProject
//
//  Created by Mia Troiano on 2/19/24.
//

import Foundation
import SwiftUI
import EventKitUI
import UserNotifications

struct CalandarView: View {
    @State var showingOptions = false
    @State var showingProfile = false
    @State private var OptionsName: String = "Home"
    @State var DatePicked: Date = Date()
    
    var body: some View {
        VStack() {
            
                DatePicker("Select Date", selection: $DatePicked, displayedComponents: [.date, .hourAndMinute])
                    .padding(.all)
                    .datePickerStyle(.graphical)
                    //Spacer()
                Text(DatePicked.formatted(date: .abbreviated, time: .shortened))
                    .font(.system(size: 24))
                    .bold()
                    .padding([.top, .leading, .trailing])
               //Divider()
            
                Button("Schedule an Alarm") {
                    let content = UNMutableNotificationContent()
                        content.title = "Alarm"
                        content.subtitle = "Wake Up!"
                        content.interruptionLevel = .critical
                        content.sound = UNNotificationSound.criticalSoundNamed(UNNotificationSoundName("alert.caf"))

                        content.sound = UNNotificationSound.default
                           
                    let pickTime = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: DatePicked)
                                   
                    let trigger = UNCalendarNotificationTrigger(dateMatching: pickTime, repeats: false)
                            
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                            
                        UNUserNotificationCenter.current().add(request)
                        }.font(.title)
                        
            
            .padding()
            .onAppear(){
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound, .criticalAlert]) { success, error in
                    if success {
                        print("approved")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }

        }
        Spacer()
        .preferredColorScheme(.light)
    }
}

#Preview {
    CalandarView()
}
