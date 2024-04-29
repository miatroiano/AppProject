//
//  TasksView.swift
//  AppProject
//
//  Created by Mia Troiano on 3/21/24.
//

import Foundation
import SwiftUI
import UserNotifications

struct TasksView: View {
    @AppStorage("Task")  var Task = "Enter Task"
    @AppStorage("TimeM")  var TimeM: Int = 0
    @AppStorage("TimeH")  var TimeH: Int = 0
    @AppStorage("Task2")  var Task2 = "Enter Task"
    @AppStorage("TimeM2")  var TimeM2: Int = 0
    @AppStorage("TimeH2")  var TimeH2: Int = 0
    @AppStorage("Task3")  var Task3 = "Enter Task"
    @AppStorage("TimeM3")  var TimeM3: Int = 0
    @AppStorage("TimeH3")  var TimeH3: Int = 0
    @AppStorage("remainingTime") var remainingTime: Int = 0
    
    var body: some View {
        VStack() {
            NavigationView {
                List {
                    NavigationLink(destination: VStack(){
                        
                        TextField(Task, text: $Task)
                            .padding(.top)
                        Stepper("Hours: \(TimeH)", value: $TimeH)
                        Stepper("Minuets: \(TimeM)", value: $TimeM)
                        
                    },
                                   label: {
                        Text("\(Task)")
                    })
                    NavigationLink(destination: VStack(){
                        TextField(Task2, text: $Task2)
                            .padding(.top)
                        Stepper("Hours: \(TimeH2)", value: $TimeH2)
                        Stepper("Minuets: \(TimeM2)", value: $TimeM2)
                    },
                                   label: {
                        Text("\(Task2)")
                    })
                    
                    NavigationLink(destination: VStack(){
                        TextField(Task3, text: $Task3)
                            .padding(.top)
                        Stepper("Hours: \(TimeH3)", value: $TimeH3)
                        Stepper("Minuets: \(TimeM3)", value: $TimeM3)
                    },
                                   label: {
                        Text("\(Task3)")
                    })
                    Button("Set Time") {
                        let newTime = (TimeH * 3600) + (TimeM * 60) + (TimeH2 * 3600) + (TimeM2 * 60) + (TimeH3 * 3600) + (TimeM3 * 60)
                        if newTime != remainingTime {
                            remainingTime = newTime
                            NotificationCenter.default.post(name: .init("TimerUpdated"), object: nil)
                        }
                    }
                    
                }
            
            .navigationTitle("My Tasks")
            .navigationBarTitleDisplayMode(/*@START_MENU_TOKEN@*/.automatic/*@END_MENU_TOKEN@*/)
        }
    }
}
}

#Preview {
    TasksView()
}

