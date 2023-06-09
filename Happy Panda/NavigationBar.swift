//
//  NavigationView.swift
//  Happy Panda
//
//  Created by Serena Huang on 5/15/23.
//

import SwiftUI

struct Food: View {
    let coreDM: DataController
    @State private var foodlist: [FoodTracker] = [FoodTracker]()
    
    
    @State var name = ""
    @State var calories:Double = 0
    
    var body: some View {
       
        VStack{
            HStack {

                Text("Food Diary")
                .font(.system(size:25))
                .bold()
            }
            NavigationView{
                VStack{
                    Text("\(Int(totalCalories())) KCal Today")
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

                                    coreDM.saveFood(name: name, calories: calories)
                                    populateList()

                                }

                                Spacer()
                            }

                        }
                        Section(header: Text("Your Entries")){
                            List{
                                ForEach(foodlist, id: \.self){
                                    item in Text("\(item.name ?? ""): \(Int(item.calories))")
                                }.onDelete(perform: {item in item.forEach{foods in let updatedfood = foodlist[foods]
                                    coreDM.deleteFood(food: updatedfood)
                                    populateList()
                                }})
                            }

                        }
//
                    }


                    Spacer()


                }
                .onAppear(perform: {
                    foodlist = coreDM.getAllFoods()
                })


            }
        }
    }
        
    
    private func totalCalories() -> Double{
        // figure out how to display total calories
        var sumCalories: Double = 0
        for item in foodlist {
            if Calendar.current.isDateInToday(item.date!){

                sumCalories += item.calories
                
            }
        }

        return sumCalories
    }
    private func populateList(){
        foodlist = coreDM.getAllFoods()
    }
}

struct Food_Previews: PreviewProvider {
    static var previews: some View {
        Food(coreDM: DataController())
    }
}

