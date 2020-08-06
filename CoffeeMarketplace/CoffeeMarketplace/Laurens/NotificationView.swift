//
//  NotificationView.swift
//  testSwiftUI
//
//  Created by Laurens Bryan Cahyana on 03/08/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI
import CloudKit

struct NotificationView: View {
    @ObservedObject var userStore : ShopData = .shared
    @ObservedObject var notificationDataList : NotificationData = .shared
    var defaultNotificationProduct = ProductData(name: "*Product Name*", description: "*description*", price: 1000, stock: 3, beanType: "Green", roastType: "Light", flavour: ["Sweet", "Nutty"], image: UIImage(named: "Coffee")!, id: nil, seller: nil)
    var defaultNotificationBuyer = buyerData(id: nil, name: "*Buyer Name*", email: "*email*", password: "*Password*", phoneNumber: "*PhoneNumber*", profilePhoto: UIImage(systemName: "person.fill")!)
    var defaultNotificationQuantity = 1
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                
                if notificationDataList.productsPurchased.isEmpty{
                    NotificationItemView(productPurchased: defaultNotificationProduct, buyer: defaultNotificationBuyer, quantity: defaultNotificationQuantity)
                }
                else if notificationDataList.productsPurchased.count == notificationDataList.buyers.count && notificationDataList.productsPurchased.count == notificationDataList.quantities.count {
                    ForEach (0 ..< notificationDataList.productsPurchased.count, id: \.self) { index in
                        NavigationLink(destination: NotificationDetail(productPurchased: self.notificationDataList.productsPurchased[index], buyer: self.notificationDataList.buyers[index], quantity: self.notificationDataList.quantities[index])) {
                            NotificationItemView(productPurchased: self.notificationDataList.productsPurchased[index], buyer: self.notificationDataList.buyers[index], quantity: self.notificationDataList.quantities[index])
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
                
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width)
        }
        .background(Image("Background").scaledToFill().edgesIgnoringSafeArea(.all))
        .navigationBarTitle("Notification", displayMode: .inline)
        .onAppear(){
            self.fetchNotification()
            print("Data Count :  \(self.notificationDataList.productsPurchased.count)")
        }
        .navigationBarItems(trailing:
            Button(action: {
                print("Refreshing...")
                self.fetchNotification()
            }) {
                Image(systemName: "arrow.clockwise")
            }
            .foregroundColor(Color.black)
            .padding(.leading, 15.0)
        )
    }
    
    func fetchNotification(){
        
        self.notificationDataList.productsPurchased.removeAll()
        self.notificationDataList.buyers.removeAll()
        self.notificationDataList.quantities.removeAll()
        
        let database = CKContainer.default().publicCloudDatabase
        
        let reference = CKRecord.Reference(recordID: userStore.id, action: .deleteSelf)
        
        let predicate = NSPredicate(format: "sellers CONTAINS %@", reference)
        
        let query = CKQuery(recordType: "Transaction", predicate: predicate)
        
        database.perform(query, inZoneWith: nil) { (results, error) in
            if let err = error {
                print(err.localizedDescription)
            }
            
            
            if let results = results {
                print(results)
                self.filterTransactionByStore(results: results)
            }
        }
    }
    
    func filterTransactionByStore(results : [CKRecord]){
        var productList : [CKRecord.Reference] = []
        var QuantityList : [Int] = []
        var buyerList : [CKRecord.Reference] = []
        
        for index in 0 ..< results.count {
            let record = results[index]
            
            let recordSellerList = record.value(forKey: "sellers") as! [CKRecord.Reference]
            
            let productPurchasedList = record.value(forKey: "productsPurchased") as! [CKRecord.Reference]
            
            let quantities = record.value(forKey: "quantities") as! [Int]
            
            
            
            for index2 in 0 ..< recordSellerList.count {
                let seller = recordSellerList[index2]
                
                if seller.recordID == userStore.id {
                    productList.append(productPurchasedList[index2])
                    QuantityList.append(quantities[index2])
                    buyerList.append(record.value(forKey: "buyer") as! CKRecord.Reference)
                }
            }
            
            
        }
        
        loadFilteredTransaction(productList: productList, quantityList: QuantityList, buyerList: buyerList)
        
        
    }
    
    func loadFilteredTransaction(productList: [CKRecord.Reference], quantityList: [Int], buyerList: [CKRecord.Reference]){
        var productImage : UIImage?
        var buyerImage : UIImage?
        let database = CKContainer.default().publicCloudDatabase
        
        for index in 0 ..< productList.count {
            let productRecord = productList[index]
            let buyerRecord = buyerList[index]
            
            //Masukin product ke list notif
            database.fetch(withRecordID: productRecord.recordID) { (result, error) in
                if let err = error {
                    print(err.localizedDescription)
                }
                if let result = result {
                    if let asset = result.value(forKey: "image") as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!){
                        productImage = UIImage(data: data)
                    }
                    
                    let product = ProductData(name: result.value(forKey: "name") as! String, description: result.value(forKey: "description") as! String, price: result.value(forKey: "price") as! Int, stock: result.value(forKey: "stock") as! Int, beanType: result.value(forKey: "beanType") as! String, roastType: result.value(forKey: "roastType") as! String, flavour: result.value(forKey: "flavour") as! [String], image: productImage!, id: result.recordID, seller: result.value(forKey: "seller") as! CKRecord.Reference)
                    
                    self.notificationDataList.productsPurchased.append(product)
                    
                    //Masukin ammount per product
                    self.notificationDataList.quantities.append(quantityList[index])
                }
            }
            
            //Masukin buyer ke list notif
            database.fetch(withRecordID: buyerRecord.recordID) { (result, error) in
                if let err = error {
                    print(err.localizedDescription)
                }
                
                if let result = result {
                    if let asset = result.value(forKey: "profilePhoto") as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!){
                        buyerImage = UIImage(data: data)
                    }
                    
                    let buyer = buyerData(id: result.recordID, name: result.value(forKey: "name") as! String, email: result.value(forKey: "email") as! String, password: result.value(forKey: "password") as! String, phoneNumber: result.value(forKey: "phoneNumber") as! String, profilePhoto: buyerImage!)
                    
                    self.notificationDataList.buyers.append(buyer)
                    
                }
            }
            
            
            
            
        }
        
        
    }
    
    
        
//        let predicate = NSPredicate(format: "email = %@ AND password = %@", argumentArray: [newLogin.email, newLogin.password])
        
        
//        // Setup
//        let pred = NSPredicate(format: "shopID", "someshopID")
//        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
//
//        let query = CKQuery(recordType: "Product", predicate: pred)
//        query.sortDescriptors = [sort]
//
//        let operation = CKQueryOperation(query: query)
//
//        operation.recordFetchedBlock = { record in
//            DispatchQueue.main.async {
//                // Do something to the data fetched
//            }
//        }
//
//        operation.queryCompletionBlock = {(_, err) in
//            DispatchQueue.main.async {
//                if let err = err {
//                    print(err)
//                    return
//                }
//            }
//        }
//
//        // Execute
//        CKContainer.default().publicCloudDatabase.add(operation)
        
    }



    
struct NotificationItemView: View {
    var productPurchased : ProductData
    var buyer : buyerData
    var quantity : Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Buyer : \(buyer.name)")
                    .font(.title)
                    .padding([.leading, .bottom], 5.0)
                Text("\(productPurchased.name)")
                    .font(.headline)
                    .padding([.leading, .bottom], 5.0)
                Text("Quantity: \(quantity), Total price: Rp.\(productPurchased.price * quantity),-")
                    .font(.body)
                    .padding([.leading, .bottom], 5.0)
            }
                .padding([.top, .leading, .bottom], 5.0)
            Spacer()
            Image("WhatsappIcon")
                .resizable()
                .padding(.trailing, 5.0)
                .frame(width: 50.0, height: 50.0)
                .foregroundColor(Color.blue)
                .onTapGesture() {
                    UIApplication.shared.open(URL(string: "https://wa.me/\(self.buyer.phoneNumber)?text=I'm%20interested%20in%20buying%20your%20coffee%20for%20sale")!)
                }
//            Button(action: {
//                openURL(URL(string: "https://wa.me/15551234567?text=I'm%20interested%20in%20your%20car%20for%20sale")!)
//            }) {
//                Image(systemName: "message")
//                    .resizable()
//                    .padding(.trailing, 5.0)
//                    .frame(width: 50.0, height: 50.0)
//                    .foregroundColor(Color.blue)
//            }
//                .padding([.top, .bottom, .trailing], 5.0)
        }
            .background(Color.white)
            .cornerRadius(20)
            .frame(width: UIScreen.main.bounds.width * 0.9)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 1)
            )
    }
}

struct NotificationDetail: View {
    var productPurchased : ProductData
    var buyer : buyerData
    var quantity : Int
    var selectedTransactionProgress = 1
    
    var body: some View {
        VStack {
            //coffee brief detail
            HStack {
                Image(uiImage: productPurchased.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 125.0, height: 125.0)
                    .clipped()
                    .cornerRadius(10.0)
                    .padding()
                VStack(alignment: .leading) {
                    Text("\(productPurchased.name)")
                        .font(.title)
                    Text("Quantity  :  \(quantity)")
                        .font(.body)
                    Text("Price        :  \(productPurchased.price)")
                        .font(.body)
                    Text("Transaction ID")
                        .font(.footnote)
                    
                }
                .padding(.trailing, 5.0)
                Spacer()
            }
                .background(Color.white)
                .cornerRadius(20.0)
                .frame(width: UIScreen.main.bounds.width * 0.9)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            //buyer contact
            HStack {
                VStack(alignment: .leading) {
                    Text("\(buyer.name)")
                        .font(.title)
                    Text("\(buyer.phoneNumber)")
                        .font(.body)
                }
                .padding([.top, .leading, .bottom])
                Spacer()
                Image("WhatsappIcon")
                    .resizable()
                    .padding()
                    .frame(width: 100.0, height: 100.0)
                    .foregroundColor(Color.blue)
                    .onTapGesture() {
                        UIApplication.shared.open(URL(string: "https://wa.me/\(self.buyer.phoneNumber)?text=I'm%20interested%20in%20buying%20your%20coffee%20for%20sale")!)
                    }
            }
                .background(Color.white)
                .cornerRadius(20.0)
                .frame(width: UIScreen.main.bounds.width * 0.9)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            //transaction process
            VStack {
                HStack {
                    VStack {
                        Text("Transaction Process")
                            .font(.title)
                        HStack{
                            Text("Ordered")
                            Spacer()
                            Image(systemName: (selectedTransactionProgress >= 1) ? "checkmark" : "")
                                .foregroundColor(/*@START_MENU_TOKEN@*/.green/*@END_MENU_TOKEN@*/)
                                .padding(.trailing)
                        }
                        .padding()
                        HStack{
                            Text("Confirmed")
                            Spacer()
                            Image(systemName: (selectedTransactionProgress >= 2) ? "checkmark" : "")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.green/*@END_MENU_TOKEN@*/)
                            .padding(.trailing)
                        }
                        .padding()
                        HStack{
                            Text("Sent")
                            Spacer()
                            Image(systemName: (selectedTransactionProgress >= 3) ? "checkmark" : "")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.green/*@END_MENU_TOKEN@*/)
                            .padding(.trailing)
                        }
                        .padding()
                        HStack{
                            Text("Arrived")
                            Spacer()
                            Image(systemName: (selectedTransactionProgress >= 4) ? "checkmark" : "")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.green/*@END_MENU_TOKEN@*/)
                            .padding(.trailing)
                        }
                        .padding()
                        HStack{
                            Text("Done")
                            Spacer()
                            Image(systemName: (selectedTransactionProgress >= 5) ? "checkmark" : "")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.green/*@END_MENU_TOKEN@*/)
                            .padding(.trailing)
                        }
                        .padding()
                    }
                }
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 1)
                    )
                
                //spacing befor button
                Spacer()
                
                //buttons
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Confirm Order Payment")
                        .foregroundColor(Color.white)
                }
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 25)
                    .background(Color.blue)
                    .cornerRadius(12.5)
                    .padding(.top)
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Item sent")
                        .foregroundColor(Color.white)
                }
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 25)
                    .background(Color.blue)
                    .cornerRadius(12.5)
                .padding(.top)
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Item Arrived")
                        .foregroundColor(Color.white)
                }
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 25)
                    .background(Color.blue)
                    .cornerRadius(12.5)
                    .padding(.top)
            }
        }
        .padding(.top)
            .background(Image("Background").edgesIgnoringSafeArea(.all))
    }
}


struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }
}


struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}


struct UserData {
    var name: String = "User Name"
    var number: String = "62811221655"
}
