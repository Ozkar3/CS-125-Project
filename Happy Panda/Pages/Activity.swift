//
//  Activity.swift
//  Happy Panda
//

import SwiftUI

struct Activity: View {
    // Activity Section ----------------------------------------
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
                            Text("Water Consumed (L)")
                            Slider(value: $hydration_level, in: 0...5, step: 0.1)
                        }
                    }
                    
                    // Steps Section ----------------------------------------
                    Section(header: Text("Steps")) {
                        HStack {
                            Text("Steps Taken")
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
                }
            }
        }
    }

    func saveActivity() {
        // Add your saving functionality here
        // This could include sending the data to a server or saving to local storage
    }

    struct Activity_Previews: PreviewProvider {
        static var previews: some View {
            Activity()
        }
    }
}
