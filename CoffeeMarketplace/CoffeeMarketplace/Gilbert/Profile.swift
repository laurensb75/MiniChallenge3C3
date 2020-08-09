//
//  Profile.swift
//  Profile Page
//
//  Created by Gilbert Gozalie on 7/20/20.
//  Copyright © 2020 Gilbert Gozalie. All rights reserved.
//

import SwiftUI

struct ProfileTest: View {
    @ObservedObject var userLoggedOn : userData = .shared
    @State var hasLogin = false
    @ObservedObject var loginState : loginStatus = .shared
    
    
    var body: some View {
        NavigationView{
            if loginState.hasLogin {
                ProfileAfterLogin()
                .navigationBarTitle("Profile", displayMode: .inline)
            }
            else{
                ProfileBeforeLogin()
                .navigationBarTitle("Profile", displayMode: .inline)
            }
        }
    }
}

struct ProfileBeforeLogin: View {
    @State var isShowingRegisterPage = false
    @State var isShowingLoginPage = false
    
    var body: some View {
        VStack(spacing: 300){

            
            Image("test")
                .resizable()
                .frame(height:150)
                .clipShape(Circle())
            
            VStack(spacing: 15){
                Button(action: {
                    // your action here
                    self.isShowingLoginPage = true
                }) {
                    Text("Log in")
                        .foregroundColor(Color.white)
                        .frame(minWidth: 0, maxWidth: 300)
                        .padding()
                        .background(Color.init(.brown))
                        .font(.title)
                        .cornerRadius(15)
                }
                Button(action: {
                    // your action here
                    self.isShowingRegisterPage = true
                }) {
                    Text("Don't have account?")
                        .padding()
                }
                
                NavigationLink(destination: MC3RegisterPage(), isActive: $isShowingRegisterPage){
                    EmptyView()
                }
                
                NavigationLink(destination: MC3LoginPage(isShowingLoginPage: $isShowingLoginPage), isActive: $isShowingLoginPage){
                    EmptyView()
                }
                
            }
        }.background(Image("Background")
            .resizable()
            .scaledToFill())
        
    }
}


struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTest()
    }
}
