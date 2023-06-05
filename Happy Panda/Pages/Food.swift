//
//  Food.swift
//  Happy Panda
//
//  Created by Maritza Pott on 5/2/23.
//

import SwiftUI

struct Food: View {
    //@EnvironmentObject var foodData : FoodData
    @State private var showingAddingEntry = false
    @State private var meals:[String:Double] = ["yogurt": 100] //[String:Int]()
    @State var name = ""
    @State var calories:Double = 0
    var body: some View {
        let keys = meals.map{$0.key}
        let values = meals.map{$0.value}
        VStack{
            HStack {
                            
                Text("Food Diary")
                .font(.system(size:25))
                .bold()
            }
            NavigationView{
                VStack{
                    Text("\(totalCalories()) KCal Today")
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        
                    
                    Form{
                        Section(header: Text("Log your Food!")){
                            
                            TextField("Food name", text: $name)
                            VStack{
                                Text("Calories: \(Int(calories))")
                                Slider(value: $calories, in: 0...1500, step: 10)
                            }
                            .padding()
                            
                            HStack{
                                Spacer()
                                Button("Submit"){
                                    meals[name] = calories
                                }
                                
                                Spacer()
                            }
                            
                        }
                        Section(header: Text("Your Entries")){
                            List{
                                ForEach(keys.indices) {index in
                                    HStack {
                                        Text("\(keys[index]) : \(Int(values[index])) calories")
                                    }
                                }
                            }
                        }
                        
                    }
                    
                    Spacer()
                    
                    
                }
                
                //            .toolbar{
                //                ToolbarItem(placement: .navigationBarTrailing){
                //                    Button{
                //                        showingAddingEntry.toggle()
                //                    } label: {
                //                        Text("New Entry")
                //                    }
                //                }
                //                ToolbarItem(placement: .navigationBarLeading){
                //                    EditButton()
                //                }
                //            }
                //            .sheet(isPresented: $showingAddingEntry){
                //                AddFoodEntry()
                //            }
            }
        }
    }
        
    
    private func totalCalories() -> Int{
        // figure out how to display total calories
        return 0
    }
}

struct Food_Previews: PreviewProvider {
    static var previews: some View {
        Food()
    }
}
