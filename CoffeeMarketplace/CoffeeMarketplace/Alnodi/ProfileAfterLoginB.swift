//
//  ProfileAfterLoginB.swift
//  CoffeeMarketplace
//
//  Created by Alnodi Adnan on 27/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI

struct ProfileAfterLoginB: View {
    
    //var currentUser : userLoggedOn
    
    var body: some View {
        VStack{
            Text("Profile After Login")
            Image.init(uiImage: userLoggedOn.profilePhoto!)
            .resizable()
            .clipShape(Circle())
            .frame(height: 100)
            .aspectRatio(contentMode: .fill)
//            Image("test")
//            .resizable()
//            .clipShape(Circle())
//            .frame(height: 100)
            Text("Username: \(userLoggedOn.name)")
        }
    }
}

struct userLoggedOn{
    static var name: String = ""
    static var profilePhoto = UIImage(named: "Background")
}

struct newUserData {
    static var profilePhoto = UIImage(named: "Background")
}

struct ProfileAfterLoginB_Previews: PreviewProvider {
    static var previews: some View {
        ProfileAfterLoginB()
    }
}
