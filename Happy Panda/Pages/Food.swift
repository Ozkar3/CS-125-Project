//
//  Food.swift
//  Happy Panda
//
//  Created by Maritza Pott on 5/2/23.
//

import SwiftUI

struct Food: View {
    @State private var showingAddingEntry = false
    @State var name = ""
    @State var calories: Double = 0
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("\(totalCalories()) KCal Today")
                .foregroundColor(.gray)
                .padding(.horizontal)
                Section(header: Text("Breakfast").font(.largeTitle)){
                    Divider()
                }
                .padding()
                
                Section(header: Text("Lunch").font(.largeTitle)){
                    Divider()
                    
                    
                }
                .padding()
                Section(header: Text("Dinner").font(.largeTitle)){
                    Divider()
                    
                }
                .padding()
                Spacer()
            }
            .navigationTitle("Food Diary")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        showingAddingEntry.toggle()
                    } label: {
                        Text("New Entry")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddingEntry){
                AddFoodEntry()
            }
        }
    }
    
    private func totalCalories() -> Int{
        // figure out how to display total calories
        return 0
    }
}

struct Food_Previews: PreviewProvider {
    static var previews: some View {
        Food()
    }
}
