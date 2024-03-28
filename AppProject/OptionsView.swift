//
//  OptionsView.swift
//  AppProject
//
//  Created by Mia Troiano on 2/19/24.
//

import Foundation
import SwiftUI
import UserNotifications

struct OptionsView: View {
    var body: some View {
        VStack() {
            NavigationView {
                List{
                    NavigationLink(destination: CalandarView(),
                                   label: {
                        Text("Set Alarm")
                    })
                    NavigationLink(destination: TasksView(),
                                   label: {
                        Text("Edit Tasks")
                    })
                    NavigationLink(destination: Text("details 3"),
                                   label: {
                        Text("Option 3")
                    })
                    NavigationLink(destination: Text("details 4"),
                                   label: {
                        Text("Option 4")
                    })
                }
                .navigationTitle("Options")
                .navigationBarTitleDisplayMode(/*@START_MENU_TOKEN@*/.automatic/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

#Preview {
    OptionsView()
}
