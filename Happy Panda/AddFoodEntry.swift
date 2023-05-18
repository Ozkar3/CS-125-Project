//
//  AddFoodEntry.swift
//  Happy Panda
//
//  Created by Maritza Pott on 5/17/23.
//

import SwiftUI

struct AddFoodEntry: View {
    @State private var name = ""
    @State private var calories: Double = 0
    @State private var selection = "Breakfast"
    let mealtimes = ["Breakfast", "Lunch", "Dinner"]
   
    var body: some View {
        Form{
            Section{
                VStack{
                    Picker("Select a meal time", selection: $selection){
                        ForEach(mealtimes, id:\.self){
                            Text($0)
                        }
                    }
                }
                TextField("Food name", text: $name)
                VStack{
                    Text("Calories: \(Int(calories))")
                    Slider(value: $calories, in: 0...1500, step: 10)
                }
                .padding()
                
                HStack{
                    Spacer()
                    Button("Submit"){
                        // Add data to firebase
                    }
                    Button("Cancel", role: .cancel, action: {})
                    Spacer()
                }
                
            }
        }
    }
}

struct AddFoodEntry_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodEntry()
    }
}
