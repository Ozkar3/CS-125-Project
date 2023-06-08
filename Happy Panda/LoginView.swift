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

    @EnvironmentObject var firestoreManager: FirestoreManager
    @EnvironmentObject var vm: HealthKitViewModel

    var body: some View {
        if userLoggedIn {
            NavigationBar() // this can be changed to whatever the next screen is after user logs in
        }
        else {
            registerLoginScreen
        }
    }

    var registerLoginScreen: some View {
            Color(red: 0.937, green: 0.945, blue: 0.961) // #eff1f5
            .ignoresSafeArea()
            .overlay(
        VStack(spacing:0) {

            Text("Discover Wellness with")
                .multilineTextAlignment(.trailing)
                .foregroundColor(.black)
                //.fontWeight(.regular)
                .font(Font.custom("Montserrat-Medium", size:20))


            Text("HAPPY PANDA")
                .font(Font.custom("Montserrat-Bold", size:45))
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .foregroundColor(.black)

            // ---------------------------------------------------------
            Text("A HEALTHIER HAPPIER YOU") // change to whatever slogan
            // ---------------------------------------------------------
                .font(Font.custom("Montserrat-SemiBold", size:20))
                .fontWeight(.bold)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                .foregroundColor(Color(red: 0.275, green: 0.455, blue: 0.098))

            Image("panda_paw")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:350, height:200)
                .offset(y:-60)


            TextField(
                "Email Address",
                text: $email)

            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding(.all,15.0)
            //.padding(.trailing,35)
            .background(.white)
            .cornerRadius(30)
            .shadow(color: .black.opacity(0.2), radius: 5, x:0, y:4)
            .frame(width: 300)
            .offset(y:-70)
            .font(.custom("Montserrat-Regular", size:20))

            SecureField(
                "Password",
                text: $password)
            .padding(.all,15)
            //.padding(.trailing,35)
            //.border(.gray,width: 2)
            .background(.white)
            .cornerRadius(30)
            .shadow(color: .black.opacity(0.2), radius: 5, x:0, y:4)
            //.overlay(RoundedRectangle(cornerRadius:30).stroke(.gray,lineWidth: 2))
            .frame(width: 300)
            .offset(y:-50)
            .font(.custom("Montserrat-Regular", size:20))


            // NavigationLink(destination: HomeView()), isActive:
            Button {
                registerLogin()
            } label: {
                Text("Login")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .font(.custom("Montserrat-Bold", size:20))
                    .frame(width: 300, height: 45)
                    .background(Color(red: 0.275, green: 0.455, blue: 0.098))
                    .cornerRadius(25)
                    .offset(y:-35)
                    .shadow(color: .black.opacity(0.2), radius: 5, x:0, y:4)
            }

            LabelledDivider(label: "or",color:Color(red: 0.498, green: 0.494, blue: 0.51))
                .offset(y:-30)

            Button {
                //registerLogin()
            } label: {
                Text("Register")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .font(.custom("Montserrat-Bold", size:20))
                    .frame(width: 300, height: 45)
                    .background(Color(red: 0.51, green: 0.737, blue: 0.286)) // #82bc49
                    .cornerRadius(25)
                    .offset(y:-25)
                    .shadow(color: .black.opacity(0.2), radius: 5, x:0, y:4)
            }


        }
        )
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
                        self.firestoreManager.loadUserData()
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(FirestoreManager())
            .environmentObject(HealthKitViewModel())
    }
}
