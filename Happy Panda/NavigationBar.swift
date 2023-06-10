//
//  NavigationView.swift
//  Happy Panda
//
//  Created by Serena Huang on 5/15/23.
//


import SwiftUI

struct NavigationBar: View {
    @State var tabSelection = 1
    
    @EnvironmentObject var firestoreManager: FirestoreManager
    @StateObject private var sharedData = SharedData()
    
    
    var body: some View {
        
                TabView(selection: $tabSelection) {
        
                    Home(tabSelection: $tabSelection)
                        .tabItem(){
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                        .tag(1)
        
                    Sleep()
                        .tabItem(){
                            Image(systemName: "cloud.moon.fill")
                            Text("Sleep")
                        }
                        .tag(2)
        
                    Food(coreDM: DataController())
                        .tabItem(){
                            Image(systemName: "carrot.fill")
                            Text("Food")
                        }
                        .tag(3)
        
                    Activity()
                        .environmentObject(sharedData)
                        .tabItem(){
                            Image(systemName: "figure.run")
                            Text("Activity")
                        }
                        .tag(4)
        
                    Profile()
                        .environmentObject(sharedData)
                        .tabItem(){
                            Image(systemName: "person.fill")
                            Text("Profile")
                        }
                        .tag(5)
        //
                }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
            .environmentObject(FirestoreManager())
            .environmentObject(HealthKitViewModel())
    }
}


