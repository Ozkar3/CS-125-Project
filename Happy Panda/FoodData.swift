//
//  FoodData.swift
//  Happy Panda
//
//  Created by Maritza Pott on 5/21/23.
//

import SwiftUI
import Firebase

class FoodData: ObservableObject {
    @Published var foods : [Food] = []
    
    init(){
        fetchfood()
    }
    
    func fetchfood(){
        let db = Firestore.firestore()
        let ref = db.collection("food")
        ref.getDocuments {snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                for document in snapshot.documents{
                    let data = document.data()
                    
                    let calories = data["calories"] as? Double ?? 0
                    //let calories_avg = data["calories_avg"] as? Double ?? 0
                    //let calories_total = data["calories_total"] as? Double ?? 0
                    
                    let food = Food(calories: calories)
                    self.foods.append(food)
                }
            }
        }
    }
    
}
