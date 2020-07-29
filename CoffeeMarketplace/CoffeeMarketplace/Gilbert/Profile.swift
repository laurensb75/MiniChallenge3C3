//
//  Profile.swift
//  Profile Page
//
//  Created by Gilbert Gozalie on 7/20/20.
//  Copyright © 2020 Gilbert Gozalie. All rights reserved.
//

import SwiftUI

struct ProfilePage: View {
    var body: some View {
            TabView{
                ProfileLogin()
            .tabItem{
                Image(systemName: "person.fill")
                Text("Profile")
            }
        }
    }
}

struct ProfileLogin: View {
    var body: some View {
                VStack(spacing: 300){
                    Image("test")
                        .resizable()
                        .frame(height:150)
                        .clipShape(Circle())

                    VStack(spacing: 15){
                    LoginButton()
                    Button(action: {
                        // your action here
                    }) {
                        Text("Don't have account?")
                        .padding()
                    }
                    
                }
            }.background(Image("Background2")
            .resizable()
            .scaledToFill())
        
    }
    }

struct LoginButton: View{
    var body: some View{
    Button(action: {
        // your action here
    }) {
        Text("Log in")
            .foregroundColor(Color.white)
            .frame(minWidth: 0, maxWidth: 300)
            .padding()
            .background(Color.init(.brown))
            .font(.title)
            .cornerRadius(15)
    }
    }
}
struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
