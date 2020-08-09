//
//  Account.swift
//  CoffeeMarketplace
//
//  Created by Gilbert Gozalie on 7/29/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI

struct TestAccount{
    var name:String
    var pass:String
}

var acc = TestAccount(name: "gilbert", pass: "123123123")

struct Account: View {
    @ObservedObject var userLoggedOn : userData = .shared
    @State var username: String = ""
    @State var phoneNumber: String = ""
    @State var email: String = ""
    
    var body: some View {
        ScrollView{
            Rectangle()
                .frame(width: 10, height: 80)
                .foregroundColor(Color.clear)
            //                Rectangle()
            //                    .frame(width: 10, height: 80)
            //                    .foregroundColor(Color.clear)
            VStack(alignment: .center, spacing: 10){
                Image(uiImage: userLoggedOn.profilePhoto)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding(.top,10)
                
                VStack(alignment: .leading){
                    Text("Name")
                        .font(.system(size: 24, weight: .bold))
                    TextField(userLoggedOn.name, text: $username)
                    HorizontalLine(color: .gray)
                }.padding(.horizontal, 25.0)
                
                VStack(alignment: .leading){
                    Text("Email")
                        .font(.system(size: 24, weight: .bold))
                    TextField(userLoggedOn.email, text: $email)
                    HorizontalLine(color: .gray)
                }.padding(.horizontal, 25.0)
                
                VStack(alignment: .leading){
                    Text("Phone Number")
                        .font(.system(size: 24, weight: .bold))
                    TextField(userLoggedOn.phoneNumber, text: $phoneNumber)
                    HorizontalLine(color: .gray)
                }.padding(.horizontal, 25.0)
                
                Button(action: {
                    // your action here
                }) {
                    Text("Edit Account")
                        .foregroundColor(Color.white)
                        .frame(minWidth: 0, maxWidth: 100)
                        .padding(5)
                        .background(Color.init(.darkGray))
                        .cornerRadius(20)
                        .padding(.bottom,10)
                }
            }
                
                .background(Color.init(.white))
                .frame(width: UIScreen.main.bounds.width * 0.9)
                .cornerRadius(10)
                .padding(10)
        }
            .onTapGesture {UIApplication.shared.endEditing()}
            .navigationBarTitle("My Account", displayMode: .inline)
            .background(Image("Background"))
            .edgesIgnoringSafeArea(.all)
    }
    
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        Account()
    }
}
