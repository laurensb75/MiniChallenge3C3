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
        TabView{ProfileAfterLoginPage()
            .tabItem{
            Image(systemName: "person.fill")
            Text("Profile")
            }

        }.background(Image("Background")
        .resizable()
        .scaledToFit())
    }
}

struct ProfileAfterLoginPage: View{
    var body: some View{
        VStack(spacing: 100){
                    Image("test")
                        .resizable()
                        .frame(height:150)
                        .clipShape(Circle())
                

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
            Button(action: {
                // your action here
            }) {
                Text("Account")
                    .foregroundColor(Color.white)
                    .frame(minWidth: 0, maxWidth: 300)
                    .padding()
                    .background(Color.init(.brown))
                    .font(.title)
                
                .cornerRadius(15)

            }
            Button(action: {
                // your action here
            }) {
                Text("Open Shop")
                    .foregroundColor(Color.white)
                    .frame(minWidth: 0, maxWidth: 300)
                    .padding()
                    .background(Color.init(.brown))
                    .font(.title)
                
                .cornerRadius(15)

            }
            Button(action: {
                // your action here
            }) {
                Text("About")
                    .foregroundColor(Color.white)
                    .frame(minWidth: 0, maxWidth: 300)
                    .padding()
                    .background(Color.init(.brown))
                    .font(.title)
                
                .cornerRadius(15)

            }
            Button(action: {
                // your action here
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
        .background(Image("Background2")
        .resizable()
        .scaledToFill())
    }
}

struct ProfileAfterLogin_Previews: PreviewProvider {
    static var previews: some View {
        ProfileAfterLogin()
    }
}
