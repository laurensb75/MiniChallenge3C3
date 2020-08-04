//
//  ProfileAfterLogin.swift
//  Profile Page
//
//  Created by Gilbert Gozalie on 7/21/20.
//  Copyright © 2020 Gilbert Gozalie. All rights reserved.
//

import SwiftUI
import CloudKit

struct ProfileAfterLogin: View {
    var body: some View {
        
        ProfileAfterLoginPage()

    }
}

struct ProfileAfterLoginPage: View{
    @ObservedObject var userLoggedOn : userData = .shared
    @State var isShowingAccountDetailView = false
    @State var isShowingMyShopView = false
    @State var isShowingOpenShopView = false
    @State var isSignedOut = false
    
    @ObservedObject var loginState : loginStatus = .shared
    @ObservedObject var UserStore : ShopData = .shared
    
    
    var body: some View{
        VStack(spacing: 50){
            Image(uiImage: userLoggedOn.profilePhoto)
                .resizable()
                .frame(width: 150, height:150)
                .clipShape(Circle())
                
            Text("Welcome, \(userLoggedOn.name)")
            
            VStack(spacing: 12){
                Button(action: {
                    // your action here
                }) {
                    Text("History Transaction")
                        .foregroundColor(Color.white)
                        .frame(minWidth: 0, maxWidth: 300)
                        .padding()
                        .background(Color.init(.brown))
                        .font(.title)
                        
                        .cornerRadius(15)
                    
                }
                NavigationLink(destination: Account(), isActive: $isShowingAccountDetailView){
                    Button(action: {
                        // your action here
                        self.isShowingAccountDetailView = true
                    }) {
                        Text("Account")
                            .foregroundColor(Color.white)
                            .frame(minWidth: 0, maxWidth: 300)
                            .padding()
                            .background(Color.init(.brown))
                            .font(.title)
                            
                            .cornerRadius(15)
                        
                    }
                }
            
                Button(action: {
                    // your action here
                    if(self.UserStore.name != "Shop Name"){
                        self.isShowingMyShopView = true
                    }
                    else{
                        self.isShowingOpenShopView = true
                    }
                }) {
                    Text(self.UserStore.name != "Shop Name" ? "My Shop" : "Open Shop")
                        .foregroundColor(Color.white)
                        .frame(minWidth: 0, maxWidth: 300)
                        .padding()
                        .background(Color.init(.brown))
                        .font(.title)
                        
                        .cornerRadius(15)
                    
                }
                
                
                NavigationLink(destination: ContentView(), isActive: $isSignedOut) {
                    Button(action: {
                        // your action here
                        self.isSignedOut = true
                        self.loginState.hasLogin = false
                        self.signOut()
                    }) {
                        Text("Sign Out")
                            .foregroundColor(Color.white)
                            .frame(minWidth: 0, maxWidth: 300)
                            .padding()
                            .background(Color.init(.brown))
                            .font(.title)
                            
                            .cornerRadius(15)
                        
                    }
                }
            }
            
            NavigationLink(destination: MyShopView(), isActive: $isShowingMyShopView){
                EmptyView()
            }
            
            NavigationLink(destination: OpenNewShopView(), isActive: $isShowingOpenShopView){
                EmptyView()
            }
            
        }
        .background(Image("Background2"))
        .onAppear(){
            //print("fetching user store data...")
            print("User Store Name : \(self.UserStore.name)")
            //self.fetchUserStoreData()
        }
    }
    
    func signOut(){
        userLoggedOn.email = ""
        userLoggedOn.id = nil
        userLoggedOn.name = ""
        userLoggedOn.password = ""
        userLoggedOn.profilePhoto = UIImage(systemName: "person.fill")!
        userLoggedOn.phoneNumber = ""
        
        UserStore.name = "Shop Name"
        UserStore.address = ""
        UserStore.id = nil
        UserStore.owner = nil
        UserStore.ownerValidID = UIImage(systemName: "person.fill")!
        UserStore.logo = UIImage(systemName: "person.fill")!
    }
    
//    func fetchUserStoreData(){
//        let database = CKContainer.default().publicCloudDatabase
//        let reference = CKRecord.Reference(recordID: userLoggedOn.id, action: .deleteSelf)
//        let predicate = NSPredicate(format: "owner == %@", reference)
//        let query = CKQuery(recordType: "Store", predicate: predicate)
//
//        database.perform(query, inZoneWith: nil) { records, error in
//            if let error = error {
//                print(error.localizedDescription)
//            }
//            else {
//                if let records = records {
//                    print(records.first)
//                    if !records.isEmpty {
//                        self.parseShopResult(records: records)
//                    }
//                }
//            }
//        }
//    }
//
//    func parseShopResult(records: [CKRecord]) {
//
//        UserStore.name = records.first?.value(forKey: "name") as! String
//        UserStore.address = records.first?.value(forKey: "address") as! String
//
//        if let asset = records.first?.value(forKey: "ownerValidID") as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!){
//            self.UserStore.ownerValidID = UIImage(data: data)!
//        }
//
//        if let asset2 = records.first?.value(forKey: "logo") as? CKAsset, let data2 = try? Data(contentsOf: asset2.fileURL!){
//            self.UserStore.logo = UIImage(data: data2)!
//        }
//
//        UserStore.owner = records.first?.value(forKey: "owner") as? CKRecord.ID
//    }
}

struct ProfileAfterLogin_Previews: PreviewProvider {
    static var previews: some View {
        ProfileAfterLogin()
    }
}
