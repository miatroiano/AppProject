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
    @State var countOff = 0
    @State var countSnooze = 0
    @State var alarmCount = 0
    
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
                    let turnOffAction = UNNotificationAction(identifier: "Off.turnOffAction", title: "Off", options: [])
                    let snoozeAction = UNNotificationAction(identifier: "Snooze.snoozeAction", title: "Snooze", options: [])

                    let alarmCategory = UNNotificationCategory(
                        identifier: "alarmCategory",
                        actions: [turnOffAction, snoozeAction],
                        intentIdentifiers: [],
                        options: .customDismissAction)

                    UNUserNotificationCenter.current().setNotificationCategories([alarmCategory])
                    
                    let content = UNMutableNotificationContent()
                        content.title = "Alarm"
                        content.subtitle = "Wake Up!"
                        content.categoryIdentifier = "alarmCategory"
                        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "alarm.wav"))
                    
                    let pickTime = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: DatePicked)
                   
                    let trigger = UNCalendarNotificationTrigger(dateMatching: pickTime, repeats: true)
                    
                    let triggerLoop = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
                
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    let requestLoop = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: triggerLoop)
                   
                   
                    
                    if(countOff <= 0){
                        UNUserNotificationCenter.current().add(request)
                        while (alarmCount <= 3){
                            UNUserNotificationCenter.current().add(requestLoop)
                            alarmCount += 1
                        }
                    }
                    
                    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
                        switch response.actionIdentifier {
                        case "Off.turnOffAction":
                            countOff += 1
                        case "Snooze.snoozeAction":
                            countSnooze += 1
                        default:
                            break
                        }
                        completionHandler()
                    }
                }.font(.title)
                    
               
            
            
                        
            
            .padding()
            .onAppear(){
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
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
