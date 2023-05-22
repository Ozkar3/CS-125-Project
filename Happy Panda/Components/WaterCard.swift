//
//  WaterCard.swift
//  Happy Panda
//
//  Created by Serena Huang on 5/21/23.
//

import SwiftUI

struct WaterCard: View {
    var body: some View {
        VStack {
            Text("Water Intake")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font.custom("Montserrat-SemiBold", size:15))
                .padding(.leading, 15)
                .padding(.top,10)
                .foregroundColor(.white)
            
            Spacer()
            Text("0\nCups")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font.custom("Montserrat-SemiBold", size:15))
                .padding(.leading, 15)
                .padding(.bottom, 15)
                .foregroundColor(.white)
        }
        .frame(width: 155, height: 150, alignment:.leading)
        .background(Color(red: 0.51, green: 0.737, blue: 0.286))
        .multilineTextAlignment(.leading)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 4)
    }
}

struct WaterCard_Previews: PreviewProvider {
    static var previews: some View {
        WaterCard()
    }
}
