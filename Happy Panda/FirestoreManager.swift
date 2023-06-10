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
        
        self.db.collection("physical").document(userUID).getDocument { snapshot, error in
            if error != nil {
                print("error")
            }
            else {
                
                self.completedActivities = snapshot?.get("completed_workouts") as? [String] ?? []
                print(self.completedActivities)
               
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
    
    
}
