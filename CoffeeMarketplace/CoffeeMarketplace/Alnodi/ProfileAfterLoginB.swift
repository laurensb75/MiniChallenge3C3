//
//  ProfileAfterLoginB.swift
//  CoffeeMarketplace
//
//  Created by Alnodi Adnan on 27/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI
import CloudKit

struct ProfileAfterLoginB: View {
    
    @State var isShowingAccountDetailView = false
    
    var body: some View {
        NavigationView{
            ZStack{
                NavigationLink(destination: ProfileAccountDetail(), isActive: $isShowingAccountDetailView){
                    EmptyView()
                }
                
                TabView{ProfileAfterLoginPageB(isShowingAccountDetailView: $isShowingAccountDetailView)
                    .tabItem{
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    
                }.background(Image("Background")
                    .resizable()
                    .scaledToFit())
            }
            
        }
        
    }
}

//struct userLoggedOn{
//    static var id: CKRecord.ID!
//    static var name: String = ""
//    static var email: String = ""
//    static var password: String = ""
//    static var phone: String = ""
//    static var profilePhoto = UIImage(systemName: "person.fill")
//}



struct ProfileAfterLoginPageB: View{
    @Binding var isShowingAccountDetailView: Bool
    
    var body: some View{
        VStack(spacing: 50){
            Image.init(uiImage: userLoggedOn.profilePhoto!)
                .resizable()
                .frame(width: 200, height: 200)
                .scaledToFit()
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
        //.resizable()
        .scaledToFill())
    }
}

struct ProfileAfterLoginB_Previews: PreviewProvider {
    static var previews: some View {
        ProfileAfterLoginB()
    }
}
