//
//  ProfileView.swift
//  CoffeeMarketplace
//
//  Created by Alnodi Adnan on 28/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        TabView{
            ProfileLoginB()
                .tabItem{
                    Image(systemName: "person.fill")
                    Text("Profile")
            }
        }
    }
}

struct ProfileLoginB: View {
    
    @State var isShowingLoginView = false
    @State var isShowingRegisterView = false
    
    var body: some View {
        NavigationView{
            VStack(spacing: 300){
                    Image.init(uiImage: userLoggedOn.profilePhoto!)
                        .resizable()
                        //.frame(height:150)
                        .scaledToFit()
                        .clipShape(Circle())
                    
                    VStack(spacing: 15){
                        
                        NavigationLink(destination: MC3LoginPage(), isActive: $isShowingLoginView){
                            EmptyView()
                        }
                        
                        NavigationLink(destination: MC3RegisterPage(), isActive: $isShowingRegisterView){
                            EmptyView()
                        }

                        
                        Button(action: {
                            // your action here
                            self.isShowingLoginView = true
                            print("Login Button Pressed")
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
                            self.isShowingRegisterView = true
                        }) {
                            Text("Don't have account?")
                                .padding()
                        }
                        
                    }
                }
                .background(Image("Background2"))
            }
        
        }
        
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
