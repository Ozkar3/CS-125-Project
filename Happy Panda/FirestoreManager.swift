//
//  FirestoreManager.swift
//  Happy Panda
//
//  Created by Serena Huang on 6/4/23.
//

import Foundation
import Firebase
import FirebaseFirestore


class FirestoreManager: ObservableObject {
    @Published var userUID: String = ""
    @Published var userName: String = ""
    @Published var completedActivities = [String]()
    @Published var steps: Int = 0
    @Published var sleepHours: Int = 0
    @Published var waterIntake: Double = 0.0
    
    private var db = Firestore.firestore()
    
    func loadUserData(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        self.userUID = uid
        print(self.userUID)
        
        self.db.collection("users").document(userUID).getDocument { snapshot, error in
            if error != nil {
                print("error")
            }
            else {
                
                self.userName = snapshot?.get("name") as? String ?? ""
                print("name: " + self.userName)
               
            }
        }
        
        // load physical data
        self.db.collection("physical").document(userUID).getDocument { snapshot, error in
            if error != nil {
                print("error")
            }
            else {
                
                self.completedActivities = snapshot?.get("completed_workouts") as? [String] ?? []
                print(self.completedActivities)
                
                self.steps = snapshot?.get("steps") as? Int ?? 0
                print(self.steps)
               
            }
        }
        
        // load sleep data
        self.db.collection("sleep").document(userUID).getDocument { snapshot, error in
            if error != nil {
                print("error")
            }
            else {
                self.sleepHours = snapshot?.get("sleep_hours") as? Int ?? 0
                print(self.sleepHours)
                
            }
        }
        
        // load other data
        self.db.collection("other").document(userUID).getDocument { snapshot, error in
            if error != nil {
                print("error")
            }
            else {
                self.waterIntake = snapshot?.get("water_intake") as? Double ?? 0.0
                print(self.waterIntake)
                
            }
        }
        
        
        print("loaded user successfully")
        
    }
    
    func createUser(){

        print("testing")
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        // initialize user data
        var data = ["name":"test", "email":"", "height":0, "weight":0, "account_created": Date(), "last_login": Date()] as [String : Any]
        Firestore.firestore().collection("users").document(uid).setData(data) { error in
            if error != nil {
                // ERROR
            }
            else {
                print("successfully added user to personal")
            }
        }
        
        // initialize sleep data
        data = ["sleep_avg":0, "sleep_hours":0, "sleep_total":0]
        Firestore.firestore().collection("sleep").document(uid).setData(data) { error in
            if error != nil {
                // ERROR
            }
            else {
                print("successfully added user to sleep")
            }
        }
        
        // initialize physical activity data
        data = ["steps":0, "steps_avg":0, "steps_total":0]
        Firestore.firestore().collection("physical").document(uid).setData(data) { error in
            if error != nil {
                // ERROR
            }
            else {
                print("successfully added user physical")
            }
        }
        
        // initialize other data
        data = ["water_intake":0, "water_intake_avg":0, "water_intake_total":0]
        Firestore.firestore().collection("other").document(uid).setData(data) { error in
            if error != nil {
                // ERROR
            }
            else {
                print("successfully added user to other")
            }
        }
        
        print("created user")
    }
    
    func setWater(amount: Double){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let data = ["water_intake":amount]
        Firestore.firestore().collection("other").document(uid).setData(data) { error in
            if error != nil {
                // ERROR
            }
            else {
                print("successfully added user to other")
            }
        }
        self.waterIntake = amount
        
    }
    
    func setSteps(amount: Int){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let data = ["steps":amount]
        Firestore.firestore().collection("physical").document(uid).setData(data) { error in
            if error != nil {
                // ERROR
            }
            else {
                print("successfully added user to other")
            }
        }
        
    }
    
    
    
    
}
