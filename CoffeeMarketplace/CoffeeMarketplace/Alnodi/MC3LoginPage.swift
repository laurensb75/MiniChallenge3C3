//
//  MC3LoginPage.swift
//  MC3LoginRegisterUsingSwiftUI
//
//  Created by Alnodi Adnan on 19/07/20.
//  Copyright © 2020 Alnodi Adnan. All rights reserved.
//

import SwiftUI
import CloudKit

struct MC3LoginPage: View {
    
    @State var newLogin = loginData()
    @State var profilePhoto = UIImage()
    @Binding var isShowingLoginPage : Bool
    
    
    
    var body: some View {
        //NavigationView {
            VStack(){
                //Untuk pemisah antara nav title dengan konten dibawahnya
                Rectangle() 
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color.clear)
                
                ZStack{
                    FormBackgroundView()
                    EmailPasswordFormText(newLogin: $newLogin)
                }
                
                LoginButton(newLogin: $newLogin, isShowingLoginPage: $isShowingLoginPage)
                Spacer()
            }
            //.frame(alignment: .topLeading)
            .background(Image("Background"))
            //.navigationBarHidden(true)
            .navigationBarTitle("Login", displayMode: .inline)
        //}
        
        
    }
}

struct loginData {
    var email: String = ""
    var password: String = ""
}

//struct MC3LoginPage_Previews: PreviewProvider {
//    static var previews: some View {
//        MC3LoginPage()
//    }
//}

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
    var lineColor = Color(red: 0.843, green: 0.843, blue: 0.852)
    
    
    var body: some View {
        
        VStack(alignment: .leading){
            Text("Email")
                .font(.system(size: 24, weight: .bold))
            
            VStack{
                TextField("Email@email.com", text: $newLogin.email)
                HorizontalLine(color: lineColor)
            }
            .padding()
            
            
            Text("Password")
                .font(.system(size: 24, weight: .bold))
            
            VStack{
                //TextField("Password", text: $newLogin.password)
                SecureField("Password", text: $newLogin.password)
                HorizontalLine(color: lineColor)
            }
            .padding()
            
            
            ForgotPasswordBtn()
        }
        .padding(.horizontal, 25.0)
    }
}

struct LoginButton: View {
    @State var isShowingProfileView = false
    
    @Binding var newLogin: loginData
    @Binding var isShowingLoginPage : Bool
    
    @ObservedObject var userLoggedOn : userData = .shared
    @ObservedObject var loginState : loginStatus = .shared
    @ObservedObject var UserStore : ShopData = .shared
    
    
    var body: some View {
        VStack{
            NavigationLink(destination: ProfileAfterLogin(), isActive: $isShowingProfileView){
                EmptyView()
            }
            
            Button (action: {
                self.fetchLoginData()
            }) {
                Text("Log in")
                    .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0))
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 60)
                
            }
            .background(Color(red: 0.511, green: 0.298, blue: 0.001))
            .cornerRadius(10)
            .padding(.top, 15)
            
        }
        
    }
    
    func fetchLoginData(){
        //fetch data dari cloudkit
        //1.Tunjuk database yang mau di fetch
        let database = CKContainer.default().publicCloudDatabase
        
        //2.Menentukan record yang mau di fetch
        let predicate = NSPredicate(format: "email = %@ AND password = %@", argumentArray: [newLogin.email, newLogin.password])
        //let predicate2 = NSPredicate(value: true) //Ngambil semua record dari querynya, tidak di filter
        let query = CKQuery(recordType: "UserData", predicate: predicate)
        
        //3.Execute query
        database.perform(query, inZoneWith: nil) { records, error in
            if let fetchedRecords = records { //kalo misal record yang diambil tidak empty
                print(fetchedRecords)
                
                if !fetchedRecords.isEmpty {
                    self.userLoggedOn.name = fetchedRecords.first?.value(forKey: "name") as! String
                    
                    self.userLoggedOn.email = fetchedRecords.first?.value(forKey: "email") as! String
                    
                    self.userLoggedOn.password = fetchedRecords.first?.value(forKey: "password") as! String
                    
                    self.userLoggedOn.phoneNumber = fetchedRecords.first?.value(forKey: "phoneNumber") as! String
                    
                    if let asset = fetchedRecords.first?.value(forKey: "profilePhoto") as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!){
                        self.userLoggedOn.profilePhoto = UIImage(data: data)!
                    }
                    
                    //print(fetchedRecords.first?.recordID)
                    self.userLoggedOn.id
                        = fetchedRecords.first?.recordID
                    
                    self.fetchUserStoreData()
                    DispatchQueue.main.async {
                        print("After Login: \(self.userLoggedOn.name)")

                    }
                }
                else {
                    print("No Login Data Found")
                }
                
            }
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                print("Masuk")
//                self.isShowingLoginPage = false
//            }
//            self.loginState.hasLogin = true
            //self.isShowingProfileView = true
        }
    }
    
    func fetchUserStoreData(){
        let database = CKContainer.default().publicCloudDatabase
        let reference = CKRecord.Reference(recordID: userLoggedOn.id, action: .deleteSelf)
        let predicate = NSPredicate(format: "owner == %@", reference)
        let query = CKQuery(recordType: "Store", predicate: predicate)
        
        database.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                if let records = records {
                    print(records.first)
                    if !records.isEmpty {
                        self.parseShopResult(records: records)
                    }
                    self.isShowingLoginPage = false
                    self.loginState.hasLogin = true
                }
            }
        }
    }
    
    func parseShopResult(records: [CKRecord]) {
        
        UserStore.id = records.first?.recordID
        UserStore.name = records.first?.value(forKey: "name") as! String
        UserStore.address = records.first?.value(forKey: "address") as! String
        
        if let asset = records.first?.value(forKey: "ownerValidID") as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!){
            self.UserStore.ownerValidID = UIImage(data: data)!
        }
        
        if let asset2 = records.first?.value(forKey: "logo") as? CKAsset, let data2 = try? Data(contentsOf: asset2.fileURL!){
            self.UserStore.logo = UIImage(data: data2)!
        }
        
        UserStore.owner = records.first?.value(forKey: "owner") as? CKRecord.ID
        
        
    }
}


struct HorizontalLineShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let fill = CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height)
        var path = Path()
        path.addRoundedRect(in: fill, cornerSize: CGSize(width: 2, height: 2))
        
        return path
    }
}

struct HorizontalLine: View {
    private var color: Color? = nil
    private var height: CGFloat = 1.0
    
    init(color: Color, height: CGFloat = 1.0) {
        self.color = color
        self.height = height
    }
    
    var body: some View {
        HorizontalLineShape().fill(self.color!).frame(minWidth: 0, maxWidth: .infinity, minHeight: height, maxHeight: height)
    }
}
