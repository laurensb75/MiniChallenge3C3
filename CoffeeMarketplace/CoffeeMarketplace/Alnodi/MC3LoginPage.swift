//
//  MC3LoginPage.swift
//  MC3LoginRegisterUsingSwiftUI
//
//  Created by Alnodi Adnan on 19/07/20.
//  Copyright © 2020 Alnodi Adnan. All rights reserved.
//

import SwiftUI
//import CloudKit

struct MC3LoginPage: View {
    
    @State var newLogin = loginData()
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.gray)
            
            VStack{
                ZStack{
                    FormBackgroundView()
                    EmailPasswordFormText(newLogin: $newLogin)
                }
                
                LoginButton(newLogin: $newLogin)
                
                Spacer()
            }
            
        }
        
    }
}

struct loginData {
    var email: String = ""
    var password: String = ""
}

struct MC3LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        MC3LoginPage()
    }
}

struct FormBackgroundView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 20, height: 300)
            .cornerRadius(20)
    }
}

struct ForgotPasswordBtn: View {
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                print("Forgot Password button pressed")
            }) {
                Text("Forgot Password?")
            }
            .padding(.horizontal, 20)
        }
    }
}

struct EmailPasswordFormText: View {
//    @State var email: String = ""
//    @State var password: String = ""
    
    @Binding var newLogin: loginData
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Email")
                .font(.system(size: 24, weight: .bold))
            
            TextField("Email@email.com", text: $newLogin.email)
                .padding()
            
            Text("Password")
                .font(.system(size: 24, weight: .bold))
            
            TextField("Password", text: $newLogin.password)
                .padding()
            
            ForgotPasswordBtn()
        }
        .padding()
    }
}

struct LoginButton: View {
    @Binding var newLogin: loginData
    
    var body: some View {
        Button (action: {
            print("Login Button pressed")
            //self.fetchLoginData()
        }) {
            Text("Log in")
                .padding()
                .frame(width: UIScreen.main.bounds.width - 60)
            
        }
        .background(Color.black)
        .cornerRadius(10)
        .padding(.top, 15)
    }
    
//    func fetchLoginData(){
//        //fetch data dari cloudkit
//        var loginResult: [CKRecord] = []
//
//        //1.Tunjuk database yang mau di fetch
//        let database = CKContainer.default().publicCloudDatabase
//
//        //2.Menentukan record yang mau di fetch
//        let predicate = NSPredicate(format: "email = %@ AND password = %@", argumentArray: [newLogin.email, newLogin.password])
//        let predicate2 = NSPredicate(value: true) //Ngambil semua record dari querynya, tidak di filter
//        let query = CKQuery(recordType: "UserData", predicate: predicate)
//
//        //3.Execute query
//        database.perform(query, inZoneWith: nil) { records, error in
//            if let fetchedRecords = records { //kalo misal record yang diambil tidak empty
//                print(fetchedRecords)
//
//                DispatchQueue.main.async {
//
//                }
//            }
//        }
//    }
}
