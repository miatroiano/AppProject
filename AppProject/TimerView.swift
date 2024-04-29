//
//  TimerView.swift
//  AppProject
//
//  Created by Mia Troiano on 4/26/24.
//

import Foundation
import SwiftUI
struct TimerView: View {
    @AppStorage("remainingTime") var remainingTime: Int = 0
    @State private var timer: Timer? = nil
    @State private var timerIsActive = false
    var body: some View {
        VStack {
            Text(timeString(time: remainingTime))
                .font(.system(size: 24))
                .bold()
            if timerIsActive {
                Button("Stop") {
                    stopTimer()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .controlSize(/*@START_MENU_TOKEN@*/.mini/*@END_MENU_TOKEN@*/)
            } else {
                Button("Start") {
                    startTimer()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .controlSize(/*@START_MENU_TOKEN@*/.mini/*@END_MENU_TOKEN@*/)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("TimerUpdated"))) { _ in
            resetTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }

    func startTimer() {
        timerIsActive = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                timer?.invalidate()
                timerIsActive = false
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timerIsActive = false
    }

    func resetTimer() {
        stopTimer()
        remainingTime = UserDefaults.standard.integer(forKey: "remainingTime")
    }
    func timeString(time: Int) -> String {
        let hours = time / 3600
        let minutes = (time % 3600) / 60
        let seconds = (time % 3600) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
