//
//  GlobalStruct.swift
//  CoffeeMarketplace
//
//  Created by Alnodi Adnan on 28/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI
import CloudKit

//struct userLoggedOn{
//    static var id: CKRecord.ID!
//    static var name: String = ""
//    static var email: String = ""
//    static var password: String = ""
//    static var phone: String = ""
//    static var profilePhoto = UIImage(systemName: "person.fill")
//} 

class userData : ObservableObject {
    var id : CKRecord.ID!
    var name : String = ""
    var email : String = ""
    var password: String = ""
    var phoneNumber : String = ""
    var profilePhoto : UIImage = UIImage(systemName: "person.fill")!
    
    static let shared = userData()
}

struct BuyerData {
    var id : CKRecord.ID!
    var name : String = ""
    var email : String = ""
    var password: String = ""
    var phoneNumber : String = ""
    var profilePhoto : UIImage = UIImage(systemName: "person.fill")!
}

struct newData {
    static var profilePhoto = UIImage(named: "test")
}

//struct ProductData {
//    var name : String = ""
//    var description : String = ""
//    var price : Int = 0
//    var stock : Int = 0
//    var beanType : String = ""
//    var roastType : String = ""
//    var flavour : [String] = []
//    var image = UIImage(named: "test")
//    var id: CKRecord.ID!
//}

struct ProductData {
    var name : String = "Coffee name"
    var description : String = "Coffee description"
    var price : Int = 100000
    var stock : Int = 10
    var beanType : String = "Roasted"
    var roastType : String = "Dark Roast"
    var flavour : [String] = ["FruityFlavour", "SpicesFlavour", "GreenVegetativeFlavour", "NuttyCocoaFlavour", "ChemicalFlavour", "SweetFlavour", "FloralFlavour", "SourFermentedFlavour", "PaperyMustyFlavour"]
    var image = UIImage(named: "test")
    var id: CKRecord.ID!
    var seller : CKRecord.Reference!
}

struct ProductPurchasedData {
    var name : String = "Coffee name"
    var description : String = "Coffee description"
    var price : Int = 100000
    var stock : Int = 10
    var beanType : String = "Roasted"
    var roastType : String = "Dark Roast"
    var flavour : [String] = ["FruityFlavour", "SpicesFlavour", "GreenVegetativeFlavour", "NuttyCocoaFlavour", "ChemicalFlavour", "SweetFlavour", "FloralFlavour", "SourFermentedFlavour", "PaperyMustyFlavour"]
    var image = UIImage(named: "test")
    var id: CKRecord.ID!
    var buyer : CKRecord.Reference!
}

class ShopData : ObservableObject {
    @Published var id : CKRecord.ID!
    @Published var owner : CKRecord.ID!
    @Published var name : String = "Shop Name"
    @Published var address : String = "Shop Address"
    @Published var ownerValidID : UIImage = UIImage(systemName: "person.fill")!
    @Published var logo : UIImage = UIImage(systemName: "person.fill")!
    
    static let shared = ShopData()
}

class TransactionData : ObservableObject {
    //var id : CKRecord.ID!
    var buyer : CKRecord.ID!
    var productsPurchased : [CKRecord.ID] = []
    //var grindStates : [Int] = []
    var quantities : [Int] = []
    var subtotals : [Int] = []
}


class Cart : ObservableObject {
    static let shared = Cart()
    
    @Published var productList : [ProductData] = []//[.init(), .init()]
    @Published var ammountList : [Int] = []//[1, 2]
    
}

class RecordResultConverted : ObservableObject {
    static let shared = RecordResultConverted()
    
    @Published var results : [ProductData] = []
}

class RecordResultRaw : ObservableObject {
    static let shared = RecordResultRaw()
    
    @Published var results : [CKRecord] = []
}

class Counter : ObservableObject {
    static let shared = Counter()
    
    @Published var count : Int = 1
}

class loginStatus : ObservableObject {
    static let shared = loginStatus()
    
    @Published var hasLogin : Bool = false
}

struct NotificationData {
    var transactionID : CKRecord.ID!
    var buyer : BuyerData
    var productsPurchased : [ProductPurchasedData]
    var quantities : [Int]
    var progressStatus : Int
}


class NotificationList : ObservableObject {
    
//    @Published var productsPurchased : [ProductData] = []
//    @Published var buyers : [BuyerData]  = []
//    @Published var quantities : [Int] = []
    @Published var list : [NotificationData] = []
    
    static let shared = NotificationList()
}

//struct Cart {
//    static var productList : [ProductData] = []
//}
