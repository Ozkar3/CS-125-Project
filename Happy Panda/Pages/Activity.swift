//
//  Activity.swift
//  Happy Panda
//

import SwiftUI
import Foundation


struct Activity: View {
    @EnvironmentObject var sharedData: SharedData // stores some of the user preferences for workouts
    @State private var completedWorkouts: [Workout] = [] // stores workouts user has selected
    @State private var currentWorkoutTime: Int = 0 // total exercise time completed
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    

    // selection of workouts with attributes to be able to find and filter based off user data/preferences
    @State private var workouts = [
        Workout(id: UUID(), name: "Squats", intensity: "High", score: 0, type: "Home", time: 1.0),
        Workout(id: UUID(), name: "Dance", intensity: "Moderate", score: 0, type: "Gym", time: 1.5),
        Workout(id: UUID(), name: "Tricep Dips", intensity: "Moderate", score: 0, type: "Home", time: 2.0),
        Workout(id: UUID(), name: "Knee Push-ups", intensity: "Low", score: 0, type: "Outdoors", time: 1.5),
        Workout(id: UUID(), name: "Jump Rope", intensity: "High", score: 0, type: "Home", time: 2.5),
        Workout(id: UUID(), name: "Yoga", intensity: "Low", score: 0, type: "Gym", time: 1.5),
        Workout(id: UUID(), name: "Cycling", intensity: "Moderate", score: 0, type: "Outdoors", time: 2.0),
        Workout(id: UUID(), name: "Plank", intensity: "High", score: 0, type: "Home", time: 1.0),
        Workout(id: UUID(), name: "Pilates", intensity: "Moderate", score: 0, type: "Gym", time: 1.5),
        Workout(id: UUID(), name: "Burpees", intensity: "High", score: 0, type: "Home", time: 2.5),
        Workout(id: UUID(), name: "Running", intensity: "High", score: 0, type: "Outdoors", time: 3.0),
        Workout(id: UUID(), name: "Swimming", intensity: "Moderate", score: 0, type: "Outdoors", time: 2.0),
        Workout(id: UUID(), name: "Sit-ups", intensity: "Low", score: 0, type: "Home", time: 1.0),
        Workout(id: UUID(), name: "Kickboxing", intensity: "High", score: 0, type: "Gym", time: 2.0),
        Workout(id: UUID(), name: "Walking", intensity: "Low", score: 0, type: "Outdoors", time: 1.0),
        Workout(id: UUID(), name: "Hiking", intensity: "Moderate", score: 0, type: "Outdoors", time: 2.5),
        Workout(id: UUID(), name: "Weightlifting", intensity: "High", score: 0, type: "Gym", time: 1.5),
        Workout(id: UUID(), name: "Circuit Training", intensity: "Moderate", score: 0, type: "Home", time: 2.0),
        Workout(id: UUID(), name: "Rowing", intensity: "High", score: 0, type: "Gym", time: 3.0),
        Workout(id: UUID(), name: "Stretching", intensity: "Low", score: 0, type: "Home", time: 1.0),
        Workout(id: UUID(), name: "Boxing", intensity: "High", score: 0, type: "Gym", time: 2.5),
        Workout(id: UUID(), name: "Climbing", intensity: "Moderate", score: 0, type: "Outdoors", time: 2.5),
        Workout(id: UUID(), name: "Jumping Jacks", intensity: "Moderate", score: 0, type: "Home", time: 1.0),
        Workout(id: UUID(), name: "Zumba", intensity: "Moderate", score: 0, type: "Gym", time: 1.5),
        Workout(id: UUID(), name: "Basketball", intensity: "High", score: 0, type: "Outdoors", time: 2.0),
        Workout(id: UUID(), name: "Biking", intensity: "Moderate", score: 0, type: "Outdoors", time: 1.5),
        Workout(id: UUID(), name: "Push-ups", intensity: "Moderate", score: 0, type: "Home", time: 1.0),
        Workout(id: UUID(), name: "Soccer", intensity: "High", score: 0, type: "Outdoors", time: 2.0),
        Workout(id: UUID(), name: "Yoga Sculpt", intensity: "Moderate", score: 0, type: "Gym", time: 1.5),
        Workout(id: UUID(), name: "Burpees", intensity: "High", score: 0, type: "Home", time: 2.0),
        Workout(id: UUID(), name: "Cycling", intensity: "Moderate", score: 0, type: "Outdoors", time: 2.5),
        Workout(id: UUID(), name: "Pilates", intensity: "Low", score: 0, type: "Gym", time: 1.0),
        Workout(id: UUID(), name: "Jump Rope", intensity: "High", score: 0, type: "Home", time: 2.0),
        Workout(id: UUID(), name: "Dancing", intensity: "Moderate", score: 0, type: "Gym", time: 1.5),
        Workout(id: UUID(), name: "Hiking", intensity: "Moderate", score: 0, type: "Outdoors", time: 2.5),
        Workout(id: UUID(), name: "Resistance Training", intensity: "High", score: 0, type: "Gym", time: 1.5),
        Workout(id: UUID(), name: "Crunches", intensity: "Low", score: 0, type: "Home", time: 1.0),
        Workout(id: UUID(), name: "Kickboxing", intensity: "High", score: 0, type: "Gym", time: 2.0),
        Workout(id: UUID(), name: "Swimming", intensity: "Moderate", score: 0, type: "Outdoors", time: 2.0),
        Workout(id: UUID(), name: "Stair Climbing", intensity: "High", score: 0, type: "Home", time: 1.5),
        Workout(id: UUID(), name: "Jump Squats", intensity: "High", score: 0, type: "Home", time: 1.0),
        Workout(id: UUID(), name: "Zumba", intensity: "Moderate", score: 0, type: "Gym", time: 1.5),
        Workout(id: UUID(), name: "Rowing Machine", intensity: "High", score: 0, type: "Gym", time: 3.0),
        Workout(id: UUID(), name: "Stretching", intensity: "Low", score: 0, type: "Home", time: 1.0),
        Workout(id: UUID(), name: "Step Aerobics", intensity: "Moderate", score: 0, type: "Gym", time: 1.5),
        Workout(id: UUID(), name: "Running", intensity: "High", score: 0, type: "Outdoors", time: 3.0),
        Workout(id: UUID(), name: "Tai Chi", intensity: "Low", score: 0, type: "Home", time: 1.0),
        Workout(id: UUID(), name: "Plyometrics", intensity: "High", score: 0, type: "Gym", time: 2.5),
        Workout(id: UUID(), name: "Walking", intensity: "Low", score: 0, type: "Outdoors", time: 1.0),
        Workout(id: UUID(), name: "Skiing", intensity: "Moderate", score: 0, type: "Outdoors", time: 2.5),
        Workout(id: UUID(), name: "Weightlifting", intensity: "High", score: 0, type: "Gym", time: 1.5)


    ]
    
    // Activity Section Variables ------------------------------------
    @State private var activity_intensity_selection = "Light Activity"
    @State private var activity_duration: Double = 30.0
    @State private var activity_time_of_day = Date()
    @State private var activity_notes = ""
    @State private var sport_selection = "Aerobic Exercise"
    @State private var hydration_level: Double = 2.0  // in liters
    @State private var steps_taken: Double = 0  // steps
    @State private var heart_rate: Double = 60  // bpm
    @State private var terrain_selection = "Flat"
    let activity_intensity = ["Light Activity", "Moderate Activity", "Intense Activity"]
    let sport_types = ["Aerobic Exercise", "Strength Training", "Flexibility Training", "Balance Exercises", "Anaerobic Exercise"]
    let terrain_types = ["Flat", "Hilly", "Mountainous", "Mixed"]
    
    // part of the recommendation system to identify the different workouts
    struct Workout: Identifiable {
        let id: UUID
        let name: String
        let intensity: String
        var score: Int
        let type: String
        let time: Double
    }
    
    // goes thru all the stored workouts and only selects the one that match the user's preference workout location
    var filteredWorkouts: [Workout] {
        workouts.filter { $0.type == sharedData.workout_preference_selection }
    }
    
    // goes thru filteredWorkouts and orders them by their score
    // workout with the highest score will be recommended at the top
    // returns top 4 workouts that the user will most likely pick
    var sortedRecommendations: [Workout] {
        let sortedWorkouts = filteredWorkouts.sorted(by: { $0.score > $1.score })
        let maxCount = min(sortedWorkouts.count, 4)
        return Array(sortedWorkouts.prefix(maxCount))
    }
    
    // happens when user selects(+) the workout
    // adds one to the selected workout score and then adds to the completed list
    func addWorkoutToCompleted(_ workout: Workout) {
        if let index = workouts.firstIndex(where: { $0.id == workout.id }) {
            workouts[index].score += 1
            currentWorkoutTime += Int(getAdjustedTime(for: workout))
        }
        completedWorkouts.append(workout)
    }
    
    // happens when user selects(-) to the workout
    // subtracts from the score so the workout is less likely to be recommended
    func subtractWorkoutScore(_ workout: Workout) {
        if let workoutIndex = workouts.firstIndex(where: { $0.id == workout.id }) {
            workouts[workoutIndex].score -= 1
        }
    }
    
    // uses the user entered preference of their exercise experience
    // modifies the workout time to be more in line with the users level
    func getAdjustedTime(for workout: Workout) -> Double {
        switch sharedData.exercise_frequency_selection {
        case "Light Active":
            return workout.time * 10
        case "Moderately Active":
            return workout.time * 15
        case "Active":
            return workout.time * 20
        default:
            return workout.time
        }
    }
    
    // used by the ProgressBar at the top to display user's progress
    // depending on the users workout level the goal goes from 30min wrkt to 90min
    var totalProgress: Double {
        switch sharedData.exercise_frequency_selection {
        case "Light Active":
            return 30.0
        case "Moderately Active":
            return 60.0
        case "Active":
            return 90.0
        default:
            return 0.0
        }
    }
    
    var body: some View {
        VStack {
            // Activity Heading --------------------------------------
            HStack {
                Image(systemName: "waveform.path.ecg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25, alignment: .center)
                
                Text(" ACTIVITY")
                    .font(.system(size:25))
                    .bold()
            }
            HStack{
                
                // this helps the user know their activity progress
                // displays a progress bar and percentage
                // progress moves each time user adds workout to completed
                if filteredWorkouts.count > 0 {
                    let progressPercentage = min((Double(currentWorkoutTime) / totalProgress) * 100, 100)
                    ProgressView(value: Double(currentWorkoutTime) / totalProgress)
                        .progressViewStyle(LinearProgressViewStyle(tint: .green))
                        .padding(.leading, -10)
                        .padding(.top, -10)
                        .frame(width: 270)
                    
                    Text("\(Int(progressPercentage))%")
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding(.top, -15)
                        .padding(.trailing, -25)
                }
            }
            
            NavigationView {
                Form {
                    // Activity Section ----------------------------------------
                    Section(header: Text("Activity")) {
                        HStack {
                            Text("Sport Type")
                            Picker("", selection: $sport_selection) {
                                ForEach(sport_types, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        HStack {
                            Text("Activity Intensity ")
                            Picker("", selection: $activity_intensity_selection) {
                                ForEach(activity_intensity, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        HStack {
                            Text("Duration (mins)")
                            Picker("", selection: $activity_duration) {
                                ForEach(10...120, id: \.self) { duration in
                                    Text("\(duration)")
                                        .tag(Double(duration))
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        HStack {
                            Text("Time of Day")
                            DatePicker("Activity Time", selection: $activity_time_of_day, displayedComponents: .hourAndMinute)
                        }
                        
                        HStack {
                            Text("Notes")
                            TextField("Enter any notes here...", text: $activity_notes)
                        }
                        
                        HStack {
                            Text("Heart Rate (bpm)")
                            Slider(value: $heart_rate, in: 50...200, step: 1)
                        }
                        
                        HStack {
                            Text("Terrain")
                            Picker("", selection: $terrain_selection) {
                                ForEach(terrain_types, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                    }
                    
                    // Hydration Section ----------------------------------------
                    Section(header: Text("Hydration")) {
                        HStack {
                            let temp_str = String(format:"%.2f", hydration_level)
                            Text("Water Consumed: "+temp_str+" L")
                            Slider(value: $hydration_level, in: 0...5, step: 0.1)
                        }
                    }
                    
                    // Steps Section ----------------------------------------
                    Section(header: Text("Steps")) {
                        HStack {
                            Text("Steps Taken:")
                            TextField("Enter steps taken...", value: $steps_taken, formatter: NumberFormatter())
                        }
                    }
                    
                    // Save Button ----------------------------------------
                    Section {
                        Button(action: {saveActivity()}, label: {
                            HStack {
                                Spacer()
                                Text("Save")
                                Spacer()
                            }
                        })
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                    }
                    
                    Section(header: Text("Recommendations")) {
                        ForEach(sortedRecommendations) { workout in
                            HStack {
                                //if !completedWorkouts.contains(where: { $0.id == workout.id }) {
                                    Text(workout.name)
                                    Spacer()
                                    Spacer()
                                    Text("\(String(format: "%.0f", getAdjustedTime(for: workout))) min")
                                        .foregroundColor(.blue)

                                Image(systemName: "minus.circle")
                                    .foregroundColor(.red)
                                    .onTapGesture {
                                        subtractWorkoutScore(workout)
                                    }
                                    .foregroundColor(.red)
                                
                                Text("\(workout.score)")
                                    .foregroundColor(.gray)
                                
                                Button(action: {
                                    addWorkoutToCompleted(workout)
                                }) {
                                    Image(systemName: "plus.circle")
                                }
                                .foregroundColor(.blue)
                            }
                        }
                    }
                    
                    Section(header: Text("Completed")) {
                        ForEach(firestoreManager.completedActivities, id:\.self) { workout in
                            Text(workout)
                        }
                        ForEach(completedWorkouts) { workout in
                            Text(workout.name)
                        }
                    }
                }
            }
        }
    }
    
    func saveActivity() {
    }
    
    struct Activity_Previews: PreviewProvider {
        static var previews: some View {
            Activity()
                .environmentObject(SharedData())
                .environmentObject(FirestoreManager())
        }
    }
}
