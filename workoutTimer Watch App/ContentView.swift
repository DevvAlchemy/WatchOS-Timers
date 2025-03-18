//
//  ContentView.swift
//  workoutTimer Watch App
//
//  Created by Royal K on 2025-03-18.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var timerManager = TimerManager()

    @State private var selectedHours = 0
    @State private var selectedMinutes = 0
    @State private var selectedSeconds = 0

    var body: some View {
        VStack {
            // Hours, Minutes, and Seconds Pickers
            HStack {
                // Hours Picker
                Picker("Hours", selection: $selectedHours) {
                    ForEach(0...23, id: \.self) { hour in
                        Text("\(hour) h").tag(hour)
                    }
                }
                .labelsHidden()
                .pickerStyle(WheelPickerStyle())
                .frame(width: 50, height: 90) // Increased height

                // Minutes Picker
                Picker("Minutes", selection: $selectedMinutes) {
                    ForEach(0...59, id: \.self) { minute in
                        Text("\(minute) m").tag(minute)
                    }
                }
                .labelsHidden()
                .pickerStyle(WheelPickerStyle())
                .frame(width: 50, height: 90) // Increased height

                // Seconds Picker
                Picker("Seconds", selection: $selectedSeconds) {
                    ForEach(Array(stride(from: 0, through: 59, by: 1)), id: \.self) { second in
                        Text("\(second) s").tag(second)
                    }
                }
                .labelsHidden()
                .pickerStyle(WheelPickerStyle())
                .frame(width: 50, height: 90) // Increased height
            }
            .disabled(timerManager.isRunning) // Disable while running

            // Timer Display - Shows countdown in HH:MM:SS.xx format
            Text("\(formattedTime(timerManager.timeRemaining))")
                .font(.system(size: 30, weight: .bold, design: .rounded).monospacedDigit()) // Reduced size
                .minimumScaleFactor(0.5) // Auto-resizes if necessary
                .foregroundColor(.white)
                .padding()

            // Controls
            HStack {
                Button(action: {
                    // Convert selected time into total seconds and start countdown
                    timerManager.selectedTime = Double((selectedHours * 3600) + (selectedMinutes * 60) + selectedSeconds)
                    timerManager.startTimer()
                }) {
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(width: 25, height: 25) // Slightly smaller buttons
                        .foregroundColor(.green)
                }

                Button(action: {
                    timerManager.pauseTimer()
                }) {
                    Image(systemName: "pause.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.yellow)
                }

                Button(action: {
                    timerManager.resetTimer()
                }) {
                    Image(systemName: "arrow.counterclockwise")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
        .background(Color.black)
    }

    // Format the time remaining as HH:MM:SS.xx (hundredths of a second)
    private func formattedTime(_ time: Double) -> String {
        let totalSeconds = Int(time)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        let hundredths = Int((time - Double(totalSeconds)) * 100) // Get hundredths of a second
        return String(format: "%02d:%02d:%02d.%02d", hours, minutes, seconds, hundredths)
    }
}


#Preview {
    ContentView()
}
