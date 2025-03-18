//
//  TimerManager.swift
//  workoutTimer Watch App
//
//  Created by Royal K on 2025-03-18.
//

import Foundation
import Combine
import WatchKit

class TimerManager: ObservableObject {
    @Published var timeRemaining: Int = 30  // Default 30 seconds
    @Published var isRunning = false
    @Published var selectedTime: Int = 30  // User-selected time

    private var timer: Timer?

    func startTimer() {
        if isRunning { return }
        isRunning = true
        timeRemaining = selectedTime  // Set countdown based on user selection

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }

            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
                WKInterfaceDevice.current().play(.click) // Haptic feedback
            } else {
                self.stopTimer()
                WKInterfaceDevice.current().play(.success) // Completion haptic
            }
        }
    }

    func pauseTimer() {
        timer?.invalidate()
        isRunning = false
    }

    func resetTimer() {
        timer?.invalidate()
        timeRemaining = selectedTime // Reset to selected time
        isRunning = false
    }

    func stopTimer() {
        timer?.invalidate()
        isRunning = false
    }
}
