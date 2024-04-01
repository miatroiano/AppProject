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
    @AppStorage("Task") private var Task = "Enter Task"
    @AppStorage("Time") private var Time = 0
    @AppStorage("Task2") private var Task2 = "Enter Task"
    @AppStorage("Time2") private var Time2 = 0
    @AppStorage("Task3") private var Task3 = "Enter Task"
    @AppStorage("Time3") private var Time3 = 0
    
    var body: some View {
        VStack() {
            Text("My Tasks")
                .font(.title)
                .padding(.trailing, 280)
                .padding(.top, -50.0)
                .padding(.bottom, -75.0)
            List {
                HStack(){
                    TextField(Task, text: $Task)
                    Stepper("Minuets: \(Time)", value: $Time)
                }
                HStack(){
                    TextField(Task2, text: $Task2)
                    Stepper("Minuets: \(Time2)", value: $Time2)
                }
                HStack(){
                    TextField(Task3, text: $Task3)
                    Stepper("Minuets: \(Time3)", value: $Time3)
                }
                
            }
            Spacer()
        }
    }
}

#Preview {
    TasksView()
}

