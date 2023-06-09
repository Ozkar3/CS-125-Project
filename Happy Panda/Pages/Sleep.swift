//
//  Sleep.swift
//  Happy Panda
//
//  Created by Maritza Pott on 5/2/23.
//


import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseDatabase

struct Sleep: View {
    @EnvironmentObject var vm: HealthKitViewModel
    @State var sleepTime = Date()
    @State var wakeUpTime = Date()
    @State var totalHours = 0
    @State var totalMinutes = 0
    @State var min = 0
    @State var max = 0
    func ageCalc(){
        if let age = vm.userAge {
            if (13 <= age && age < 19){
                min = 8
                max = 10
            }
            else if (age >= 19){
                min = 7
                max = 9
            }
        }
    }
    let calendar = Calendar.current
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    
    private let database = Database.database().reference()
    
    
    
    var body: some View {
        VStack{
            HStack {
                
                Text("Sleep Diary")
                    .font(.system(size:25))
                    .bold()
            }
            NavigationView {
                VStack(alignment: .center) {
                    datePickers
                    HStack{
                        Text("Sleep Results")
                            .font(.system(size:20))
                            .bold()
                    }
                    .offset(y: -100)
                    
                    RecommendationResults
                    
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
                
            }
            
        }
        

    }
//    func recommendedPath() {
//        if (13 <= age && age < 19){
//            RecommendationResultsTeens
//        }
//    }
        

    var datePickers: some View {
        Form{
            Section(header:Text("What time did you go to sleep?")){
                DatePicker("Date/Time", selection:$sleepTime)
                    
                    
                    
            }
            Section(header:Text("What time did you wake up?")){
                DatePicker("Date/Time", selection:$wakeUpTime)
            }
            Button(action: {saveTime()}, label: {
                Text("Save")


            })
            
            .frame(maxWidth: .infinity, alignment: .center)
            
            
        
        }
        
        
    
    }
    func saveTime(){
        // !!! Still need to know how to save this information into the firebase
        
        // saves the total time slept
        let totalTimePassed = Calendar.current.dateComponents([.hour, .minute], from: sleepTime, to: wakeUpTime)
        // total hours slept
        totalHours = totalTimePassed.hour ?? 0
        // total minutes slept
        totalMinutes = totalTimePassed.minute ?? 0
        
        
        
//        let docData: [String: Any] = [
//            "sleep_avg": 0,
//            "sleep_hours": totalHours,
//            "sleep_total": totalTimePassed,
//        ]
//        let db = Firestore.firestore()
//
//        let docRef = db.collection("sleep").document(firestoreManager.userUID)
//
//        docRef.setData(docData) { error in
//            if let error = error {
//                print("Error writing document: \(error)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
    }
    
    
    
    
   
    
    
    var RecommendationResults: some View{
        
        // we could replace 7 with a variable holding the users age and then recommend appropiate sleeping time
       
        
        VStack(alignment: .center){
        
            
            
            if (min <= totalHours && totalHours < max){
                Section{
                    Image("happypanda")
                        .resizable()
                        .frame(width: 110.0, height: 100.0)
                    Text("You are getting a good amount of sleep! You should aim to sleep for \(min) - \(max) hours")
                        .position(x:190, y:10)
                }
                .offset(x:0, y:10)
                    
            }
            else if (0 <= totalHours && totalHours < min){
                
                Section{
                    Image("sleepypanda")
                        .resizable()
                        .frame(width: 110.0, height: 100.0)
                    Spacer()
                    Text("Needs Improvement. You need \(min) - \(max) hours of sleep for a great rest")
                        .padding(5.0)
                        .position(x:190, y:10)
                }
                .offset(x:0, y:10)
            }
            else if (totalHours > max){
                
                Section{
                    Image("tiredpanda")
                        .resizable()
                        .frame(width: 110.0, height: 100.0)
                    Text("Thats too much sleep! Try sleeping within the recommended amount of \(min) - \(max)")
                        .padding()
                        .position(x:190, y:10)
                }
                .offset(x:-3, y:10)
                
            }
        }
        .frame(width: 380, height: 230)
        .padding(.leading)
        .background(Color(red: 0.51, green: 0.737, blue: 0.286))
        .cornerRadius(20)
        .offset(x: 0, y: -100)
        
    }
    
    

}

struct Sleep_Previews: PreviewProvider {
    static var previews: some View {
        Sleep().environmentObject(HealthKitViewModel())
    }
}



