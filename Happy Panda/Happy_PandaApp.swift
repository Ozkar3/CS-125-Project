//  CS 125 - Group 10
//  Happy_PandaApp.swift
//  Happy Panda Wellness App
//
//


import SwiftUI
import Firebase

// used for Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}


@main
struct Happy_PandaApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // HealthKit
    @StateObject var healthKitViewModel = HealthKitViewModel()
    
    // Database
    @StateObject var firestoreManager = FirestoreManager()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(firestoreManager)
                .environmentObject(healthKitViewModel)
                .environmentObject(DataController())
            
            // to skip login screen for quick testing comment ^ and uncomment this v
            // need to temporarily comment out Text("Welcome, \(firestoreManager.userName)") from home to avoid errors
            //            NavigationBar()
            //                .environmentObject(healthKitViewModel)
        }
    }
}






