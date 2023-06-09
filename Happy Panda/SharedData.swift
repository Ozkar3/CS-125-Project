//
//  SharedData.swift
//  Happy Panda
//
//  Created by Oscar Zaragoza on 6/9/23.
//

import Foundation

class SharedData: ObservableObject {
    @Published var someValue: String = "asdf"
    @Published var workout_preference_selection: String = "Gym"
    @Published var exercise_frequency_selection: String = "Moderately Active"
    
    
    func getWorkoutPreferenceSelection() -> String {
        return workout_preference_selection
    }
}
