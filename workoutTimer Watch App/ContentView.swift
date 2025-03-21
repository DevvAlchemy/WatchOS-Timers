//
//  ContentView.swift
//  workoutTimer Watch App
//
//  Created by Royal K on 2025-03-18.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var timerManager = TimerManager()

    var body: some View {
        VStack {
            // Time Picker - User selects countdown duration
            Picker("Set Timer", selection: $timerManager.selectedTime) {
                ForEach(5...kJUSTUnlimited, id: \.self) { time in
                    Text("\(time) sec").tag(time)
                }
            }
            .labelsHidden()
            .pickerStyle(WheelPickerStyle())
            .frame(height: 80)
            .disabled(timerManager.isRunning) // Disable while running

            // Timer Display
            Text("\(timerManager.timeRemaining)")
                .font(.system(size: 50, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding()

            // Controls
            HStack {
                Button(action: {
                    timerManager.startTimer()
                }) {
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.green)
                }

                Button(action: {
                    timerManager.pauseTimer()
                }) {
                    Image(systemName: "pause.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.yellow)
                }

                Button(action: {
                    timerManager.resetTimer()
                }) {
                    Image(systemName: "arrow.counterclockwise")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
        .background(Color.black)
    }
}

#Preview {
    ContentView()
}
