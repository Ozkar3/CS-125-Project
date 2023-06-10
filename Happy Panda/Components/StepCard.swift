//
//  StepCard.swift
//  Happy Panda
//
//  Created by Serena Huang on 5/21/23.
//

import SwiftUI

struct StepCard: View {
    @EnvironmentObject var firestoreManager: FirestoreManager
    
    var body: some View {
        VStack {
            Text("Steps")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font.custom("Montserrat-SemiBold", size:15))
                .padding()
            
            Text("\(firestoreManager.steps)\nSteps")
                .frame(maxWidth: .infinity, maxHeight:.infinity, alignment: .center)
                .font(Font.custom("Montserrat-SemiBold", size:15))
                .multilineTextAlignment(.center)
                .padding(.bottom, 50)
            Spacer()
            
        }
        .frame(width: 155, height: 240)
        .background(.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 4)
    }
}

struct StepCard_Previews: PreviewProvider {
    static var previews: some View {
        StepCard().environmentObject(FirestoreManager())
    }
}
