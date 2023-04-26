//
//  ContentView.swift
//  Happy Panda
//
//  Created by Oscar Zaragoza on 4/25/23.
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing:30) {
            Text("HAPPY PANDA")
                .font( .system(size:45))
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .offset(y:-10)
            
            TextField(
                    "User name",
                    text: $username)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.all,15)
                    //.padding(.trailing,35)
                    .border(.black,width: 5)
                    .frame(width: 315)
                    //.offset(y:50)
            SecureField(
                    "Password",
                    text: $password)
            .padding(.all,15)
            //.padding(.trailing,35)
            .border(.black,width: 5)
            .frame(width: 315)
            //.offset(y:50)
            
            Button {
                
            } label: {
                Text("Log In")
                    .foregroundColor(.white)
                    //.bold()
                    .fontWeight(.heavy)
                    .frame(width: 150, height: 45)
                    .background(RoundedRectangle(cornerRadius: 5)
                    ).foregroundColor(.black)
                    //.offset(y:80)
                }
            
            
            
            
            
            
            
            
            
               
            Image("panda")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(y:100)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

