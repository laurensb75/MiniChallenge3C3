//
//  MC3RegisterPage.swift
//  MC3LoginRegisterUsingSwiftUI
//
//  Created by Alnodi Adnan on 19/07/20.
//  Copyright © 2020 Alnodi Adnan. All rights reserved.
//

import SwiftUI
//import CloudKit

//var newUser : userData?

struct MC3RegisterPage: View {
    
    @State var newUser = userData()
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.gray)
            
            VStack{
                ZStack{
                    RegisterFormBackgroundView()
                    RegisterFormText(newUser: $newUser)
                }
                
                RegisterButton(newUser: $newUser)
                
                Spacer()
            }
            
        }
        
    }
}

struct userData {
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var phoneNumber: String = ""
}

struct RegisterFormBackgroundView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 20, height: 500)
            .cornerRadius(20)
    }
}


struct RegisterFormText: View {
    @Binding var newUser: userData
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Name")
                .font(.system(size: 24, weight: .bold))
            TextField("Name", text: $newUser.name)
                .padding()
            
            Text("Email")
                .font(.system(size: 24, weight: .bold))
            TextField("Email@email.com", text: $newUser.email)
                .padding()
            
            Text("Password")
                .font(.system(size: 24, weight: .bold))
            TextField("Password", text: $newUser.password)
                .padding()
            
            Text("Phone Number")
                .font(.system(size: 24, weight: .bold))
            TextField("Phone Number", text: $newUser.phoneNumber)
                .padding()
                .keyboardType(UIKeyboardType.decimalPad)
            
        }
        .padding()
    }
    
    
    
    func saveToCloudKit(){
        print("Data saved")
    }
}

struct RegisterButton: View {
    @Binding var newUser: userData
    
    var body: some View {
        Button (action: {
            //self.saveDataToCloudKit()
        }) {
            Text("Register")
                .padding()
                .frame(width: UIScreen.main.bounds.width - 60)
            
        }
        .background(Color.black)
        .cornerRadius(10)
        .padding(.top, 15)
    }
    
//    func saveDataToCloudKit(){
//        //Insert data ke cloudkit
//
//        //1.Buat dulu recordnya
//        let newRecord = CKRecord(recordType: "UserData")
//
//        //2.Set property
//        newRecord.setValue(newUser.name, forKey: "name")
//        newRecord.setValue(newUser.email, forKey: "email")
//        newRecord.setValue(newUser.password, forKey: "password")
//        newRecord.setValue(newUser.phoneNumber, forKey: "phoneNumber")
//
//        //3.Execute save or insert
//        let database = CKContainer.default().publicCloudDatabase
//        database.save(newRecord) { record, error in
//            if let err = error {
//                print(err.localizedDescription)
//            }
//
//            print(record)
//
//            DispatchQueue.main.async {
//                //Update UI
//            }
//
//        }
//    }
}


struct MC3RegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        MC3RegisterPage()
    }
}



