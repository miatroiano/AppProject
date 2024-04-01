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
    @AppStorage("Time")  var Time = 0
    @AppStorage("Task2")  var Task2 = "Enter Task"
    @AppStorage("Time2")  var Time2 = 0
    @AppStorage("Task3")  var Task3 = "Enter Task"
    @AppStorage("Time3")  var Time3 = 0
    
    var body: some View {
        VStack() {
            NavigationView {
                List {
                    NavigationLink(destination: HStack(){
                        TextField(Task, text: $Task)
                            .padding(.bottom, 700.0)
                            .padding(.horizontal)
                        Stepper("Minuets: \(Time)", value: $Time)
                            .padding(.bottom, 700.0)
                            .padding(.horizontal)
                        
                    },
                                   label: {
                        Text("\(Task)")
                    })
                    NavigationLink(destination: HStack(){
                        TextField(Task2, text: $Task2)
                            .padding(.bottom, 700.0)
                            .padding(.horizontal)
                        Stepper("Minuets: \(Time2)", value: $Time2)
                            .padding(.bottom, 700.0)
                            .padding(.horizontal)
                    },
                                   label: {
                        Text("\(Task2)")
                    })
                    
                    NavigationLink(destination: HStack(){
                        TextField(Task3, text: $Task3)
                            .padding(.bottom, 700.0)
                            .padding(.horizontal)
                        Stepper("Minuets: \(Time3)", value: $Time3)
                            .padding(.bottom, 700.0)
                            .padding(.horizontal)
                    },
                                   label: {
                        Text("\(Task3)")
                    })
                    
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

