//
//  LifestyleCard.swift
//  Happy Panda
//
//  Created by Serena Huang on 5/21/23.
//

import SwiftUI

struct LifestyleCard: View {
    var body: some View {
        VStack {
            Text("Lifestyle Score")
                .font(Font.custom("Montserrat-SemiBold", size:15))
                .padding(.leading,15)
                .padding(.top, 10)
            
            Spacer()
            
        }
        .frame(width: 155, height: 120, alignment:.leading)
        .background(.white)
        .multilineTextAlignment(.leading)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 4)
        
    }
}

struct LifestyleCard_Previews: PreviewProvider {
    static var previews: some View {
        LifestyleCard()
    }
}
