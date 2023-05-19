//
//  NavigationView.swift
//  Happy Panda
//
//  Created by Serena Huang on 5/15/23.
//

import SwiftUI

struct NavigationBar: View {
    var body: some View {
        TabView {
            Home()
                .tabItem(){
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            Sleep()
                .tabItem(){
                    Image(systemName: "cloud.moon.fill")
                    Text("Sleep")
                }
            Food()
                .tabItem(){
                    Image(systemName: "carrot.fill")
                    Text("Food")
                }
            Activity()
                .tabItem(){
                    Image(systemName: "figure.run")
                    Text("Activity")
                }
            
            Profile()
                .tabItem(){
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
            
        }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}

