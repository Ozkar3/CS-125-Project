//
//  Home.swift
//  Happy Panda
//
//  Created by Serena Huang on 5/15/23.
//

import SwiftUI

struct Home: View {
    @Binding var tabSelection: Int
    @State var searchText: String = ""

    var body: some View {
        
        Color(red: 0.937, green: 0.945, blue: 0.961) // #eff1f5
        .ignoresSafeArea()
        .overlay(
        ScrollView{

            VStack(spacing:10){
                
                Text("Welcome, User!")
                    .frame(width: 330,alignment:.leading)
                    .font(Font.custom("Montserrat-SemiBold", size:30))

                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(searchText.isEmpty ? Color.gray: Color.black)
                        .padding(.leading)
                    
                    TextField("Search", text:$searchText)
                        .foregroundColor(Color.black)
                        .frame(width:300, height:35)
                        .font(Font.custom("Montserrat-Regular", size:15))
                        
                    
                }
                .background(RoundedRectangle(cornerRadius: 25)
                .fill(.white))
                
                
                HStack(spacing:20){
                    VStack(spacing:20){
                        StepCard()
                            .onTapGesture {tabSelection=4}
                        
                        WaterCard()
                        
                        Spacer()
                    }
                    
                    VStack(spacing:20){
                        LifestyleCard()
                        
                        SleepCard()
                            .onTapGesture {tabSelection=2}
                        
                        FoodCard()
                            .onTapGesture {tabSelection=3}
                        
                        Spacer()
                        
                    }
                    
                }
                .offset(y:10)
                
                RecipeCard()
                    .onTapGesture {tabSelection=3}
            }
        })
    }

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(tabSelection: .constant(1))
    }
}

