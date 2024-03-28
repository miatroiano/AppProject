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
    @State private var TaskInput: String = ""
    @State var value = 5
    var body: some View {
        VStack() {
            Text("My Tasks")
            
                .font(.largeTitle)
                .padding(.trailing, 280)
                .padding(.bottom)
            HStack(){
                TextField(
                    "Add Task",
                    text: $TaskInput
                )
                .padding(.horizontal)
                Stepper("Minuets: \(value)", value: $value)
                    .padding(.trailing)
            }
            .padding(.bottom)
            HStack(){
                TextField(
                    "Add Task",
                    text: $TaskInput
                )
                .padding(.horizontal)
                Stepper("Minuets: \(value)", value: $value)
                    .padding(.trailing)
            }
            .padding(.bottom)
            HStack(){
                TextField(
                    "Add Task",
                    text: $TaskInput
                )
                .padding(.horizontal)
                Stepper("Minuets: \(value)", value: $value)
                    .padding(.trailing)
            }
            //.padding(.bottom)
            Spacer()
        }
    }
}

#Preview {
    TasksView()
}

