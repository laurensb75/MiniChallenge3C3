//
//  ProfileAfterLogin.swift
//  Profile Page
//
//  Created by Gilbert Gozalie on 7/21/20.
//  Copyright © 2020 Gilbert Gozalie. All rights reserved.
//

import SwiftUI

struct ProfileAfterLogin: View {
    var body: some View {
        
        ProfileAfterLoginPage()

    }
}

struct ProfileAfterLoginPage: View{
    @ObservedObject var userLoggedOn : userData = .shared
    @State var isShowingAccountDetailView = false
    @State var isShowingMyShopView = false
    @State var isSignedOut = false
    @ObservedObject var loginState : loginStatus = .shared
    
    
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
                
                NavigationLink(destination: MyShopView(), isActive: $isShowingMyShopView){
                    Button(action: {
                        // your action here
                        self.isShowingMyShopView = true
                    }) {
                        Text("My Shop")
                            .foregroundColor(Color.white)
                            .frame(minWidth: 0, maxWidth: 300)
                            .padding()
                            .background(Color.init(.brown))
                            .font(.title)
                            
                            .cornerRadius(15)
                        
                    }
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
            
        }
        .background(Image("Background2"))

    }
    
    func signOut(){
        userLoggedOn.email = ""
        userLoggedOn.id = nil
        userLoggedOn.name = ""
        userLoggedOn.password = ""
        userLoggedOn.profilePhoto = UIImage(systemName: "person.fill")!
        userLoggedOn.phoneNumber = ""
    }
}

struct ProfileAfterLogin_Previews: PreviewProvider {
    static var previews: some View {
        ProfileAfterLogin()
    }
}
