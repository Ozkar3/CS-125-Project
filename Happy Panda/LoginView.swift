//  CS 125 ..
//  LoginView.swift
//  Happy Panda Wellness App
//
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing:30) {
            Text("HAPPY PANDA")
                .font( .system(size:45))
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .offset(y:-10)
            
            TextField(
                "Username",
                text: $email)
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
                login() // will fix this
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

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                print("logged in!")
            }
         
          // ...
        }
    }
    
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) {
            result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

