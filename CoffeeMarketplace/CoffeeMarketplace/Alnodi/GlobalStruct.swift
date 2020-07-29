//
//  GlobalStruct.swift
//  CoffeeMarketplace
//
//  Created by Alnodi Adnan on 28/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI
import CloudKit

struct userLoggedOn{
    static var id: CKRecord.ID!
    static var name: String = ""
    static var email: String = ""
    static var password: String = ""
    static var phone: String = ""
    static var profilePhoto = UIImage(systemName: "person.fill")
}

struct newData {
    static var profilePhoto = UIImage(named: "test")
}
