//
//  ProfileAccountDetail.swift
//  CoffeeMarketplace
//
//  Created by Alnodi Adnan on 28/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI

struct ProfileAccountDetail: View {
    @ObservedObject var userLoggedOn : userData = .shared
    
    var body: some View {
        VStack{
            Image.init(uiImage: userLoggedOn.profilePhoto)
            .resizable()
            .scaledToFit()
            .frame(height:100)
            .clipShape(Circle())
            
            Text("Name: \(userLoggedOn.name)")
            Text("Email: \(userLoggedOn.email)")
            Text("Password: \(userLoggedOn.password)")
            Text("PhoneNumber: \(userLoggedOn.phoneNumber)")
        }
    }
}

struct ProfileAccountDetail_Previews: PreviewProvider {
    static var previews: some View {
        ProfileAccountDetail()
    }
}
