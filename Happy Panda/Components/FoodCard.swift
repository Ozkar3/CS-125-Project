//
//  FoodCard.swift
//  Happy Panda
//
//  Created by Serena Huang on 5/21/23.
//

import SwiftUI

struct FoodCard: View {
    var body: some View {
        VStack {
            Text("Nutrients")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font.custom("Montserrat-SemiBold", size:15))
                .padding(.leading,15)
                //.padding(.top, 10)
            
            
            Text("Calories: 0\nCarbohydrates: 0\nProteins: 0\nFats: 0")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font.custom("Montserrat-SemiBold", size:12))
                .padding(.leading,15)
                .padding(.top, 30)
            
            //Spacer()
            
        }
        .frame(width: 155, height: 150, alignment:.leading)
        .background(.white)
        .multilineTextAlignment(.leading)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 4)
        
    }
}

struct FoodCard_Previews: PreviewProvider {
    static var previews: some View {
        FoodCard()
    }
}
