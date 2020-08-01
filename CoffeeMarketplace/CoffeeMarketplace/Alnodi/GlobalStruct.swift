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

struct ProductData {
    var name : String = ""
    var description : String = ""
    var price : Int = 0
    var stock : Int = 0
    var beanType : String = ""
    var roastType : String = ""
    var flavour : [String] = []
    var image = UIImage(named: "test")
    var id: CKRecord.ID!
}

class CartB : ObservableObject {
    static let shared = CartB()
    
    @Published var productList : [ProductData] = []
}

class RecordResultConverted : ObservableObject {
    static let shared = RecordResultConverted()
    
    @Published var results : [ProductData] = []
}

class RecordResultRaw : ObservableObject {
    static let shared = RecordResultRaw()
    
    @Published var results : [CKRecord] = []
}

struct Cart {
    static var productList : [ProductData] = []
}
