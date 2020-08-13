//
//  CartView.swift
//  testSwiftUI
//
//  Created by Laurens Bryan Cahyana on 30/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI
import CloudKit

struct CartView: View {
    
    @ObservedObject var cart : Cart = .shared
    @ObservedObject var userLoggedOn : userData = .shared
    @ObservedObject var loginState : loginStatus = .shared
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView{
                    if cart.productList.isEmpty {
                        Text("No item in cart.").padding(.top, UIScreen.main.bounds.height * 0.3)
                            .foregroundColor(.secondary)
                    }
                    else {
                        ForEach(0 ..< cart.productList.count, id: \.self) { index in
                            CartItemIcon(ammount: self.cart.ammountList[index],product: self.cart.productList[index], indexSelected: index
                            )
                        }
                    }
                }
                .padding(.top)
                if loginState.hasLogin {
                    Button(action: {
                        self.checkout()
                        print("success")
                        self.cart.ammountList.removeAll()
                        self.cart.productList.removeAll()
                    }) {
                        Text("Checkout")
                            .foregroundColor(Color.white)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.6, height: 45)
                    .background(Color.init(.brown))
                    .cornerRadius(10.0).padding(.bottom, 16.0)
                }
                else {
                    Button(action: {

                    }) {
                        Text("You need to login first before proceeding to checkout!")
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.7, height: 60)
                    .background(Color.init(.brown))
                    .cornerRadius(10.0).padding(.bottom, 16.0)
                    .disabled(true)
                }
                Spacer()
                
                
                
            }.background(Image("Background").scaledToFill().edgesIgnoringSafeArea(.all))
                .navigationBarTitle("Cart",displayMode: .inline)
        }
        .onAppear(){
            print("user loggedOn Name : \(self.userLoggedOn.name)")
            print("hasLogin : \(self.loginState.hasLogin)")
        }
    }
    
    func checkout(){
        var productReferences : [CKRecord.Reference] = []
        var sellerReferences : [CKRecord.Reference] = []
        var sellerReference : CKRecord.Reference?
    
        let database = CKContainer.default().publicCloudDatabase
    
        
        let buyerReference = CKRecord.Reference(recordID: userLoggedOn.id, action: .deleteSelf)
    
    
//        for index in 0 ..< cart.productList.count {
//            //Create reference per product purchased
//            let productReference = CKRecord.Reference(recordID: cart.productList[index].id, action: .deleteSelf)
//            productReferences.append(productReference)
//
//            //get seller per product
//
//
//            database.fetch(withRecordID: cart.productList[index].seller.recordID) { (result, error) in
//                if let err = error {
//                    print(err.localizedDescription)
//                }
//
//
//                if let result = result {
//
//
//                    sellerReference = CKRecord.Reference(recordID: result.recordID, action: .deleteSelf)
//                    print("REFERENCES : ")
//                    print(sellerReference)
//                    sellerReferences.append(sellerReference!)
//                }
//
//            }
//        }
        
        //MARK: Transaction Creation Algorythm 2
        
        var sellersInvolvedList : [CKRecord.Reference] = []
        var productsPurchased : [CKRecord.Reference] = []
        var quantities : [Int] = []
        
        for index in 0 ..< cart.productList.count {
            let sellerReference = cart.productList[index].seller!
            
            print(!sellersInvolvedList.contains(sellerReference))
            if !sellersInvolvedList.contains(sellerReference){
                sellersInvolvedList.append(sellerReference)
                //print("seller involved:")
                print("seller involved: \(sellersInvolvedList.count)")
            }
        }
        
        for index in 0 ..< sellersInvolvedList.count {
            let sellerReference = sellersInvolvedList[index]
            productsPurchased.removeAll()
            quantities.removeAll()
            let newRecord = CKRecord(recordType: "Transaction")
            
            for index2 in 0 ..< cart.productList.count {
                if cart.productList[index2].seller == sellerReference {
                    productsPurchased.append(CKRecord.Reference(recordID: cart.productList[index2].id, action: .deleteSelf))
                    quantities.append(cart.ammountList[index2])
                }
            }
            
            print("masuk")
            
            newRecord.setValue(buyerReference, forKey: "buyer")
            newRecord.setValue(productsPurchased, forKey: "productsPurchased")
            newRecord.setValue(sellerReference, forKey: "seller")
            newRecord.setValue(quantities, forKey: "quantities")
            newRecord.setValue(1, forKey: "progressStatus")
            
            
            database.save(newRecord) { (record, error) in
                if let err = error{
                    print(err.localizedDescription)
                }
                if let record = record {
                    print(record)
                }
            }
            
        }
    
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
//            newRecord.setValue(buyerReference, forKey: "buyer")
//            newRecord.setValue(productReferences, forKey: "productsPurchased")
//            newRecord.setValue(sellerReferences, forKey: "sellers")
//            newRecord.setValue(self.cart.ammountList, forKey: "quantities")
//
////            print("SELLER REFERENCES BEFORE SAVE: ")
////            print(sellerReferences)
//
//            database.save(newRecord) { (record, error) in
//                if let err = error {
//                    print(err.localizedDescription)
//                }
//                else{
//                    print(record!)
//                }
//            }
//        }
    
    }
    
}


struct CartItemIcon: View {
    @State var ammount: Int = 1
    @State var grindState = 0
    var product : ProductData
    var indexSelected : Int
    @ObservedObject var cart : Cart = .shared
    
    var body: some View {
        HStack{
            Image(uiImage: product.image!)
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.4)
                .cornerRadius(10)
                .padding(.leading)
            VStack {
                VStack(alignment: .leading){
                    HStack{
                        Text(product.name)
                            .font(.headline)
                        Spacer()
                        Button(action: {
                            self.cart.productList.remove(at: self.indexSelected)
                            print("item deleted")
                        }) {
                            Image(systemName: "trash.fill").resizable().frame(width: UIScreen.main.bounds.width * 0.045, height: UIScreen.main.bounds.width * 0.05).aspectRatio(contentMode: .fit).foregroundColor(Color.black)
                        }
                    }
                    Text("Rp.\(product.price),-")
                    
                    HStack{
                        Text("Qty")
                        HStack{
                            TextField("0", value: $ammount, formatter: NumberFormatter()).padding(.leading, 10.0).keyboardType(UIKeyboardType.decimalPad)
                            VStack{
                                Button(action: {
                                    self.ammount += 1
                                    print("ammount up")
                                }) {
                                    Image(systemName: "chevron.up")
                                }
                                .padding(.trailing, 5.0)
                                Button(action: {
                                    self.ammount -= (self.ammount<=1 ? 0 : 1)
                                }) {
                                    Image(systemName: "chevron.down")
                                }
                                .padding(.trailing, 5.0)
                            }
                        }.frame(width: 60, height: 40).border(Color.black, width: 1)
                        Spacer()
                        
                    }
                    
                }
                Picker(selection: $grindState, label: Text("Grind State")) {
                    Text("Beans").tag(1)
                    Text("Grinded").tag(2)
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Spacer()
        }
            .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 1)
            )
            .cornerRadius(20)
    }
}


struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}


//HStack{
//        Image("Coffee")
//            .resizable()
//            .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.4)
//            .cornerRadius(10)
//            .padding(.leading)
//        VStack {
//            VStack(alignment: .leading){
//                Text(coffeeItem.name)
//                    .font(.headline)
//                Text("Rp.\(coffeeItem.price),-")
//                HStack{
//                    Text("Qty")
//                    HStack{
//                        TextField("0", value: $ammount, formatter: NumberFormatter()).padding(.leading, 10.0).keyboardType(UIKeyboardType.decimalPad)
//                        VStack{
//                            Button(action: {
//                                self.ammount += 1
//                            }) {
//                                Image(systemName: "chevron.up")
//                            }
//                            .padding(.trailing, 5.0)
//                            Button(action: {
//                                self.ammount -= (self.ammount<=1 ? 0 : 1)
//                            }) {
//                                Image(systemName: "chevron.down")
//                            }
//                            .padding(.trailing, 5.0)
//                        }
//                    }.frame(width: 60, height: 40).border(Color.black, width: 1)
//                    Spacer()
//                    Button(action: {
//                        print("asdfasdf")
//                    }) {
//                        Image(systemName: "trash").resizable().frame(width: UIScreen.main.bounds.width * 0.075, height: UIScreen.main.bounds.width * 0.075).aspectRatio(contentMode: .fit)
//                    }
//                }
//            }
//            Picker(selection: $grindState, label: Text("Grind State")) {
//                Text("Beans").tag(1)
//                Text("Grinded").tag(2)
//                }.frame(width: 100.0, height: 50).clipped()
//        }
//
//        Spacer()
//        }.cornerRadius(15).frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
//}



