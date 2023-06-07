//
//  Profile.swift
//  Happy Panda
//
//
//

import SwiftUI

struct Profile: View {
    // About Section -------------------------------------
    @State private var sex_selection = "Male"
    @State var height_selection: Double = 5.0
    @State private var occupation_selection = "Student"
    let sex = ["Male", "Female"]
    let occupation = ["Student", "Part-time Employee", "Full-time Employee"]
    
    // Food Section -------------------------------------
    @State private var nutrition_selection = "Balanced Diet"
    @State private var allergies_selection = "None"
    let nutrition = ["Balanced Diet", "Vegan"]
    let allergies = ["None", "Peanuts", "Fish", "Milk", "Shellfish", "Bamboo"]
    
    // Excercise Section ----------------------------------------
    @State private var exercise_frequency_selection = "Moderately Active"
    @State private var workout_preference_selection = "Gym"
    let exercise = ["Light Active", "Moderately Active", "Active"]
    let workout_preference = ["Home", "Gym", "Outdoors", "No Preference"]
    
    // Sleep Section -----------------------------------------
    @State private var sleep_goal_selection = "Adequate (6-8hrs)"
    @State private var sleep_schedule_selection = "Early Bird"
    let sleep = ["Short (less than 6hrs)", "Adequate (6-8hrs)", "Extended (more than 8hrs)"]
    let sleep_schedule = ["Early Bird", "Regular Sleeper", "Night Owl"]
    
    
    var body: some View {
        VStack {
            // Profile Heading --------------------------------------
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25, alignment: .center)
                
                Text(" PROFILE")
                    .font(.system(size:25))
                    .bold()
            }
            
            NavigationView {
                List {
                    // About Section -------------------------------------
                    Section(header: Text("About")) {
                        HStack {
                            Text("Name")
                            Text("Panda") // retrieve from database
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    
                        HStack {
                            Text("Email")
                            Text("panda@uci.edu") // retrieve from database
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        
                        HStack {
                            Text("Sex")
                            Picker("", selection: $sex_selection) {
                                ForEach(sex, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        HStack {
                            Text("Date of Birth")
                            DatePicker(selection: .constant(Date()), displayedComponents: .date) {
                                
                            }
                            .datePickerStyle(.automatic)
                            .offset(x:8)
                        }
                        
                        HStack {
                            Text("Height")
                            Picker("", selection: $height_selection) {
                                ForEach(40...70, id: \.self) { height in
                                    Text(String(format: "%.1f", Double(height)/10.0))
                                        .tag(Double(height)/10.0)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        HStack {
                            Text("Occupation")
                            Picker("", selection: $occupation_selection) {
                                ForEach(occupation, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                    }
                    
                    // Food Section -------------------------------------
                    Section(header: Text("Food")) {
                        HStack {
                            Text("Nutrition Preference")
                            Picker("", selection: $nutrition_selection) {
                                ForEach(nutrition, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        HStack {
                            Text("Food Allergies")
                            Picker("", selection: $allergies_selection) {
                                ForEach(allergies, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                    }
                    
                    // Excercise Section ----------------------------------------
                    Section(header: Text("Exercise")) {
                        HStack {
                            Text("Exercise Frequency ")
                            Picker("", selection: $exercise_frequency_selection) {
                                ForEach(exercise, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        HStack {
                            Text("Workout Preference ")
                            Picker("", selection: $workout_preference_selection) {
                                ForEach(workout_preference, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                    }
                    
                    // Sleep Section -----------------------------------------
                    Section(header: Text("Sleep")) {
                        HStack {
                            Text("Sleep Goal")
                            Picker("", selection: $sleep_goal_selection) {
                                ForEach(sleep, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        HStack {
                            Text("Sleep Schedule")
                            Picker("", selection: $sleep_schedule_selection) {
                                ForEach(sleep_schedule, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                    }
                    
                    // End Section --------------------------------------
                    Image("panda_eating")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
    
    struct Profile_Previews: PreviewProvider {
        static var previews: some View {
            Profile()
        }
    }
}
