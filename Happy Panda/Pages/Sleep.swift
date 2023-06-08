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
                    .offset(y: -150)
                    
                    RecommendationResults
                    
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
                
            }
            
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
                Section{
                    Image("happypanda")
                        .resizable()
                        .frame(width: 110.0, height: 100.0)
                    Text("good sleep!")
                        .position(x:190, y:10)
                }
                .offset(x:0, y:10)
                    
            }
            else if (1 <= totalHours && totalHours < 7){
                
                Section{
                    Image("sleepypanda")
                        .resizable()
                        .frame(width: 110.0, height: 100.0)
                    Spacer()
                    Text("Needs Improvement. You need 7 hours of sleep for a great rest")
                        .padding(5.0)
                        .position(x:190, y:10)
                }
                .offset(x:0, y:10)
            }
            else if (totalHours > 7){
                
                Section{
                    Image("tiredpanda")
                        .resizable()
                        .frame(width: 110.0, height: 100.0)
                    Text("Thats too much sleep! Try sleeping within the recommended amount")
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
        .offset(x: 0, y: -140)
        
    }
    

}

struct Sleep_Previews: PreviewProvider {
    static var previews: some View {
        Sleep()
    }
}
