//
//  SleepCard.swift
//  Happy Panda
//
//  Created by Serena Huang on 5/16/23.
//

import SwiftUI

struct SleepCard: View {
    
    var body: some View {
        VStack {
            Text("Sleep\n\n0.0\nHours")
                .font(Font.custom("Montserrat-SemiBold", size:15))
                .padding(.leading, 20)
                .foregroundColor(.white)
            
        }
        .frame(width: 155, height: 100, alignment:.leading)
        .background(Color(red: 0.51, green: 0.737, blue: 0.286))
        .multilineTextAlignment(.leading)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 4)
        
    }
}

struct SleepCard_Previews: PreviewProvider {
    static var previews: some View {
        SleepCard()
    }
}
