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
            Text(DatePicked.formatted(date: .abbreviated, time: .shortened))
                .font(.system(size: 24))
                .bold()
//notif here
        }
        Spacer()
        .preferredColorScheme(.light)
    }
}
#Preview {
    CalandarView()
}
//            Button("Schedule an Alarm") {
//                let turnOffAction = UNNotificationAction(identifier: "Off.turnOffAction", title: "Off", options: [])
//                let snoozeAction = UNNotificationAction(identifier: "Snooze.snoozeAction", title: "Snooze", options: [])
//                let alarmCategory = UNNotificationCategory(
//                    identifier: "alarmCategory",
//                    actions: [turnOffAction, snoozeAction],
//                    intentIdentifiers: [],
//                    options: .customDismissAction)
//                UNUserNotificationCenter.current().setNotificationCategories([alarmCategory])
//                let content = UNMutableNotificationContent()
//                content.title = "Alarm"
//                content.subtitle = "Wake Up!"
//                content.categoryIdentifier = "alarmCategory"
//                content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "alarm.wav"))
//                let pickTime = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: DatePicked)
//                //first alarm
//                let trigger = UNCalendarNotificationTrigger(dateMatching: pickTime, repeats: true)
//                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//                //keep alarms going
//                let triggerLoop = UNTimeIntervalNotificationTrigger(timeInterval: 13, repeats: false)
//                let requestLoop = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: triggerLoop)
//
//                let triggerLooptwo = UNTimeIntervalNotificationTrigger(timeInterval: 26, repeats: false)
//                let requestLooptwo = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: triggerLooptwo)
//
//                let triggerSnooze = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
//                let requestSnooze = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: triggerSnooze)
//
//                let triggerSnoozetwo = UNTimeIntervalNotificationTrigger(timeInterval: 73, repeats: false)
//                let requestSnoozetwo = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: triggerSnoozetwo)
//
//                let triggerSnoozethree = UNTimeIntervalNotificationTrigger(timeInterval: 86, repeats: false)
//                let requestSnoozethree = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: triggerSnoozetwo)
//
//
//                while(alarmCount == 0){
//                    let currentTime = Date()
//                    if isTimeEqual(currentTime, DatePicked) {
//                        print("The times are equal.")
//                        alarmCount += 1
//                    }
//                }
//                if(countOff <= 0){
//                    UNUserNotificationCenter.current().add(request)
//                    if (alarmCount >= 1){
//                        UNUserNotificationCenter.current().add(requestLoop)
//                        UNUserNotificationCenter.current().add(requestLooptwo)
//                    }
//                }
//
//                if(countSnooze >= 1){
//                    countOff += 1
//                    UNUserNotificationCenter.current().add(requestSnooze)
//                    UNUserNotificationCenter.current().add(requestSnoozetwo)
//                    UNUserNotificationCenter.current().add(requestSnoozethree)
//                }
//                func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//                    switch response.actionIdentifier {
//                    case "Off.turnOffAction":
//                        countOff += 1
//                    case "Snooze.snoozeAction":
//                        countSnooze += 1
//                    default:
//                        break
//                    }
//                    completionHandler()
//                }
//                func isTimeEqual(_ date1: Date, _ date2: Date) -> Bool {
//                    let calendar = Calendar.current
//                    let components1 = calendar.dateComponents([.hour, .minute], from: date1)
//                    let components2 = calendar.dateComponents([.hour, .minute], from: date2)
//                    return components1.hour == components2.hour && components1.minute == components2.minute
//                }
//
//            }.font(.title)
//                .padding()
//                .onAppear(){
//                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//                        if success {
//                            print("approved")
//                        } else if let error = error {
//                            print(error.localizedDescription)
//                        }
//                    }
//                }
