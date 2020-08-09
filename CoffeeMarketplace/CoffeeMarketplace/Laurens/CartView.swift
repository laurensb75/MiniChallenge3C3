//
//  CartView.swift
//  testSwiftUI
//
//  Created by Laurens Bryan Cahyana on 30/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI
<<<<<<< HEAD
import CloudKit

struct CartView: View {
    
    @ObservedObject var cart : Cart = .shared
    @ObservedObject var userLoggedOn : userData = .shared
=======

struct CartView: View {
    let itemInCart: [Coffeee] = [
        .init(id: "1", name: "Trending Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "2", name: "Trending Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 110000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "3", name: "Trending Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 150000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "4", name: "Trending Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 125000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Trending Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 375000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
    ]
    
    @ObservedObject var cart : Cart = .shared
>>>>>>> origin/calvin
    
    var body: some View {
        NavigationView{
            VStack{
<<<<<<< HEAD
                ScrollView{
                    if cart.productList.isEmpty {
                        Text("No item")
                    }
                    else {
                        ForEach(0 ..< cart.productList.count, id: \.self) { index in
                            CartItemIcon(ammount: self.cart.ammountList[index],product: self.cart.productList[index], indexSelected: index
                            )
                        }
                    }
                }
                .padding(.top)
                Spacer()
                Button(action: {
                    self.checkout()
=======
                if cart.productList.isEmpty {
                    Text("No item")
                }
                else {
                    ForEach(0 ..< cart.productList.count, id: \.self) { index in
                        CartItemIcon(ammount: self.cart.ammountList[index],product: self.cart.productList[index], indexSelected: index)
                            .border(Color.black, width: 1)
                    }
                }
                
//                List(itemInCart) { item in
//                    CartItemIcon(coffeeItem: item, ammount: 1).border(Color.black, width: 1).cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
//                }
                
                Spacer()
                Button(action: {
                    
>>>>>>> origin/calvin
                }) {
                    Text("Checkout")
                        .foregroundColor(Color.black)
                }
                    .frame(width: UIScreen.main.bounds.width * 0.6, height: 45)
                    .background(Color.init(.brown))
<<<<<<< HEAD
                .cornerRadius(10.0).padding(.bottom, 16.0)
            }.background(Image("Background").scaledToFill().edgesIgnoringSafeArea(.all))
                .navigationBarTitle("Cart",displayMode: .inline)
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
    
=======
                    .cornerRadius(10.0)
            }
            .navigationBarTitle("Cart", displayMode: .automatic)
        }
    }
>>>>>>> origin/calvin
}


struct CartItemIcon: View {
<<<<<<< HEAD
=======
    //var coffeeItem: Coffeee = .init(id: "0", name: "Coffee Name", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 0, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
>>>>>>> origin/calvin
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
<<<<<<< HEAD
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
=======
                    Text(product.name)
                        .font(.headline)
                    
>>>>>>> origin/calvin
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
<<<<<<< HEAD
                        
=======
                        Button(action: {
                            self.cart.productList.remove(at: self.indexSelected)
                            print("item deleted")
                        }) {
                            Image(systemName: "trash").resizable().frame(width: UIScreen.main.bounds.width * 0.075, height: UIScreen.main.bounds.width * 0.075).aspectRatio(contentMode: .fit)
                        }
>>>>>>> origin/calvin
                    }
                    
                }
                Picker(selection: $grindState, label: Text("Grind State")) {
                    Text("Beans").tag(1)
                    Text("Grinded").tag(2)
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Spacer()
<<<<<<< HEAD
        }.frame(width: UIScreen.main.bounds.width * 0.9, height: 200).background(Color.white).overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 1)).cornerRadius(20)
=======
            }.cornerRadius(15).frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
>>>>>>> origin/calvin
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
<<<<<<< HEAD



=======
>>>>>>> origin/calvin
