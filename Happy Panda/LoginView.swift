//  CS 125 - Group 10
//  LoginView.swift
//  Happy Panda Wellness App
//
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userLoggedIn = false
    
    var body: some View {
        if userLoggedIn {
            // -----------------------------------------------------------
            SleepView() // change to whatever screen is after user logs in
            // -----------------------------------------------------------
        }
        else {
            registerLoginScreen
        }
    }
    
    var registerLoginScreen: some View {
        VStack(spacing:0) {
            Text("Discover Wellness with")
                .multilineTextAlignment(.trailing)
                .foregroundColor(.black)
                .fontWeight(.regular)
                .font( .system(size:18))
            
            Text("HAPPY PANDA")
                .font( .system(size:45))
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .foregroundColor(.black)
            // ---------------------------------------------------------
            Text("A HEALTHIER HAPPIER YOU") // change to whatever slogan
            // ---------------------------------------------------------
                .font( .system(size:18))
                .fontWeight(.bold)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                .foregroundColor(.green)
            
            TextField(
                "Username",
                text: $email)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding(.all,15)
            .border(.black,width: 3.5)
            .frame(width: 315)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            .foregroundColor(.green)
            
            SecureField(
                "Password",
                text: $password)
            .padding(.all,15)
            .border(.black,width: 3.5)
            .frame(width: 315)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
            .foregroundColor(.green)
            
            Button {
                registerLogin()
            } label: {
                Text("Register / Log In")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .frame(width: 200, height: 45)
                    .background(RoundedRectangle(cornerRadius: 5)
                    ).foregroundColor(.green)
                    .offset(y:20)
            }
            
            Image("panda")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(y:100)
        }
    }
    
    
    // when user taps on "Register/Login" button
    // first tries to register user given email & password
    // if detects already user then logs them in
    // if not then registers user and then logs in
    
    func registerLogin() {
        Auth.auth().createUser(withEmail: email, password: password) {
            result, error in
            if error != nil {
                print(error!.localizedDescription)
                Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                    if error != nil {
                        print(error!.localizedDescription)
                    }
                    else {
                        print("User logged in!")
                        userLoggedIn.toggle()
                    }
                }
            }
            else {
                print("Account created and logged in!")
                userLoggedIn.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
