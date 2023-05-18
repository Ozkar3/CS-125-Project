//
//  Sleep.swift
//  Happy Panda
//
//  Created by Maritza Pott on 5/2/23.
//

import SwiftUI

struct Sleep: View {
    @State var sleepTime = Date()
    @State var wakeUpTime = Date()
    @State var totalHours = 0
    @State var totalMinutes = 0
    let calendar = Calendar.current
    
    
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                datePickers
                RecommendationResults
                
                
                
                    
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            .navigationBarTitle("Log In Your Sleep!", displayMode: .automatic)
   
        }

    }
        

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
        
        
    }
    
    var RecommendationResults: some View{
        
        // we could replace 7 with a variable holding the users age and then recommend appropiate sleeping time
        
        VStack(alignment: .center){
            if (totalHours == 7){
                Image("happypanda")
                    .resizable()
                    .frame(width: 110.0, height: 100.0)
                Text("good sleep!")
                    .position(x: 200)
                    
            }
            else if (1 <= totalHours && totalHours < 7){
                Image("sleepypanda")
                    .resizable()
                    .frame(width: 110.0, height: 100.0)
                Text("Needs Improvement. You need 7 hours of sleep for a great rest")
                    .padding(5.0)
                    .position(x:200)
            }
            else if (totalHours > 7){
                Image("tiredpanda")
                    .resizable()
                    .frame(width: 110.0, height: 100.0)
                Text("Thats too much sleep!")
                    .padding()
                    .position(x:200)
                
            }
        }
        
        
    }
    

}

struct Sleep_Previews: PreviewProvider {
    static var previews: some View {
        Sleep()
    }
}
