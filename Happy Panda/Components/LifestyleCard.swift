//
//  LifestyleCard.swift
//  Happy Panda
//
//  Created by Serena Huang on 5/21/23.
//

import SwiftUI

struct LifestyleCard: View {
    
    @State var progressValue: Float = 0.2
    
    var body: some View {
        VStack {
            Text("Lifestyle Score")
                .font(Font.custom("Montserrat-SemiBold", size:15))
                .padding(.leading,15)
            
            ProgressBar(progress: self.$progressValue)
                .frame(width:60, height: 60)
                .padding(.leading,30)
 
        }
        .frame(width: 155, height: 120, alignment:.leading)
        .background(.white)
        .multilineTextAlignment(.leading)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 4)
    }
}


struct ProgressBar: View {
    @Binding var progress: Float
    
    var body: some View {
   
        ZStack {
            Circle()
                .stroke(lineWidth: 6.0)
                .opacity(0.3)
                .foregroundColor(Color(red: 0.51, green: 0.737, blue: 0.286))

            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 6.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color(red: 0.51, green: 0.737, blue: 0.286))
                .rotationEffect(Angle(degrees: 270.0))

            Text(String(format: "%.0f%", min(self.progress, 1.0)*100.0))
                .font(Font.custom("Montserrat-SemiBold", size:15))
        }
    }
}


struct LifestyleCard_Previews: PreviewProvider {
    static var previews: some View {
        LifestyleCard()
    }
}
