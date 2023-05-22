//
//  RecipeCard.swift
//  Happy Panda
//
//  Created by Serena Huang on 5/21/23.
//

import SwiftUI

struct RecipeCard: View {
    var body: some View {
        VStack {
            Text("Recipes For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font.custom("Montserrat-SemiBold", size:15))
                .padding(.leading, 15)
                .padding(.top,10)
            
            Spacer()
        }
        .frame(width: 330, height: 280, alignment:.leading)
        .background(.white)
        .multilineTextAlignment(.leading)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 4)
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCard()
    }
}
