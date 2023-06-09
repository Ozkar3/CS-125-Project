//
//  Profile.swift
//  Happy Panda
//
// 
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var vm: HealthKitViewModel
    @EnvironmentObject var sharedData: SharedData
    
    // About Section -------------------------------------
    @State private var sex_selection = "Male"
    @State private var height_selection = 60
    @State private var weight: Double = 0.0
    @State private var feet_selection = 5
    @State private var inches_selection = 6
    @State private var bmi: Double = 0.0
    
    
    @State private var occupation_selection = "Student"
    let sex = ["Male", "Female"]
    let occupation = ["Student", "Part-time Employee", "Full-time Employee"]
    
    // Food Section -------------------------------------
    @State private var nutrition_selection = "Balanced Diet"
    @State private var allergies_selection = "None"
    let nutrition = ["Balanced Diet", "Vegan"]
    let allergies = ["None", "Peanuts", "Fish", "Milk", "Shellfish", "Bamboo"]
    
    // Excercise Section ----------------------------------------
    //@State private var exercise_frequency_selection = "Moderately Active"
    //@State private var workout_preference_selection = "Gym"
    let exercise = ["Light Active", "Moderately Active", "Active"]
    let workout_preference = ["Home", "Gym", "Outdoors", "No Preference"]
    
    // Sleep Section -----------------------------------------
    @State private var sleep_goal_selection = "Adequate (6-8hrs)"
    @State private var sleep_schedule_selection = "Early Bird"
    let sleep = ["Short (less than 6hrs)", "Adequate (6-8hrs)", "Extended (more than 8hrs)"]
    let sleep_schedule = ["Early Bird", "Regular Sleeper", "Night Owl"]
    
    var calculateBMI: Double {
        let heightInInches = (feet_selection * 12) + (inches_selection)
        let bmi = weight/((Double(heightInInches))*(Double(heightInInches)))*703
        return bmi
    }
    
    var body: some View {
        VStack {
            
            // Profile Heading --------------------------------------
            if vm.isAuthorized {
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
                                if let sex = vm.userSex {
                                    Text(sex)
                                        .foregroundColor(.blue)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                else{
                                    Picker("", selection: $sex_selection) {
                                        ForEach(sex, id: \.self) {
                                            Text($0)
                                        }
                                    }
                                    .pickerStyle(.menu)
                                }
                            }
                            HStack {
                                Text("Age")
                                if let age = vm.userAge {
                                    Text("\(age)")
                                        .foregroundColor(.blue)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                } else {
                                    Text("Not Set")
                                        .foregroundColor(.blue)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                            }
                            // 
                            //                            DatePicker(selection: .constant(Date()), displayedComponents: .date) {
                            //
                            //                            }
                            //                            .datePickerStyle(.automatic)
                            //                            .offset(x:8)
                            
                            
                            //                        HStack {
                            //                                Text("Height (in)")
                            //                                Picker("", selection: $height_selection) {
                            //                                    ForEach(48...84, id: \.self) { height in
                            //                                        Text("\(height)")
                            //                                            .tag(height)
                            //                                    }
                            //                                }
                            //                                .pickerStyle(.menu)
                            //                            }
                            HStack {
                                Text("Height")
                                Spacer().frame(width: 110)
                                Picker("", selection: $feet_selection) {
                                    ForEach(4...7, id: \.self) { feet in
                                        Text("\(feet)")
                                            .tag(feet)
                                    }
                                }
                                .pickerStyle(.menu)
                                Text("ft")
                                Picker("", selection: $inches_selection) {
                                    ForEach(0...11, id: \.self) { inches in
                                        Text("\(inches)")
                                            .tag(inches)
                                    }
                                }
                                .pickerStyle(.menu)
                                Text("in")
                            }
                            HStack {
                                Text("Weight (lb)")
                                Spacer()
                                TextField("Enter your weight", value: $weight, format: .number)
                                    .textFieldStyle(.roundedBorder)
                                    .frame(width: 40)
                                //Text("Entered weight: \(weight, specifier: "%.1f")")
                                
                            }
                            HStack {
                                Text("BMI")
                                //                                if bmi == 0.0 {
                                //                                    Text("Weight needed")
                                //                                }
                                Text(" \(calculateBMI, specifier: "%.1f")")
                                    .foregroundColor(.blue)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                
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
                                Picker("", selection: $sharedData.exercise_frequency_selection) {
                                    ForEach(exercise, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(.menu)
                            }
                            HStack {
                                Text("Workout Preference ")
                                Picker("", selection: $sharedData.workout_preference_selection) {
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
                        Button {
                            vm.healthRequest()
                        } label: {
                            Text("Authorize HealthKit")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .frame(width: 320, height: 55)
                        .background(Color(red: 0.51, green: 0.737, blue: 0.286))
                        .cornerRadius(10)
                        
                        VStack {
                            
                            Text("Step Count")
                                .font(.title3)
                            
                            Text("\(vm.userStepCount)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            if let sleepDuration = vm.userSleepDuration {
                                Text("Today's Sleep Duration")
                                    .font(.title3)
                                
                                Text("\(sleepDuration)")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                            } else {
                                Text("No sleep data available")
                                    .font(.title3)
                            }
                            
                            if let age = vm.userAge {
                                Text("Age")
                                    .font(.title3)
                                
                                Text("\(age)")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                            }
                            
                            //                            if let height = vm.userHeight {
                            //                                Text("Height")
                            //                                    .font(.title3)
                            //
                            //                                Text("\(height, specifier: "%.2f")")
                            //                                    .font(.largeTitle)
                            //                                    .fontWeight(.bold)
                            //                            }
                            //
                            //                            if let weight = vm.userWeight {
                            //                                Text("Weight")
                            //                                    .font(.title3)
                            //
                            //                                Text("\(weight, specifier: "%.2f")")
                            //                                    .font(.largeTitle)
                            //                                    .fontWeight(.bold)
                            //                            }
                            
                            if let sex = vm.userSex {
                                
                                Text("Sex")
                                    .font(.title3)
                                Text(sex)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                            }
                            
                            
                        }
                        
                        // End Section --------------------------------------
                        Image("panda_eating")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                }
                
            } else {
                VStack {
                    Text("Authorize Health to retrieve data!")
                        .font(.title3)
                    
                    Button {
                        vm.healthRequest()
                    } label: {
                        Text("Authorize HealthKit")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .frame(width: 320, height: 55)
                    .background(Color(red: 0.51, green: 0.737, blue: 0.286))
                    .cornerRadius(10)
                }
            }
        }.onAppear {
            vm.readStepsTakenToday()
            vm.readSleepDuration()
            vm.readAge()
            vm.readHeight()
            vm.readWeight()
            vm.readSex()
        }
        
    }
    
    struct Profile_Previews: PreviewProvider {
        static var previews: some View {
            Profile()
                .environmentObject(HealthKitViewModel())
                .environmentObject(SharedData())
        }
    }
}
