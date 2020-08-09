//
//  NotificationView.swift
//  testSwiftUI
//
//  Created by Laurens Bryan Cahyana on 03/08/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI
<<<<<<< HEAD
import CloudKit

struct NotificationView: View {
    @ObservedObject var userStore : ShopData = .shared
    @ObservedObject var notificationDataList : NotificationList = .shared
    var defaultNotificationProduct = ProductData(name: "*Product Name*", description: "*description*", price: 1000, stock: 3, beanType: "Green", roastType: "Light", flavour: ["Sweet", "Nutty"], image: UIImage(named: "Coffee")!, id: nil, seller: nil)
    var defaultNotificationBuyer = BuyerData(id: nil, name: "*Buyer Name*", email: "*email*", password: "*Password*", phoneNumber: "*PhoneNumber*", profilePhoto: UIImage(systemName: "person.fill")!)
    var defaultNotificationQuantity = 1
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                if notificationDataList.list.isEmpty{
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.gray)
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.3)
                    .overlay(
                        Text("No Notification")
                    )
                }
                else {
                    ForEach (0 ..< notificationDataList.list.count, id: \.self) { index in
//                        NavigationLink(destination: NotificationDetail(productPurchased: self.notificationDataList.list[index].productsPurchased.first!, buyer: self.notificationDataList.list[index].buyer, quantity: self.notificationDataList.list[index].quantities.first!, selectedTransactionProgress: self.notificationDataList.list[index].progressStatus, indexSelected: index)) {
//                            NotificationItemView(productPurchased: self.notificationDataList.list[index].productsPurchased.first!, buyer: self.notificationDataList.list[index].buyer, quantity: self.notificationDataList.list[index].quantities.first!)
//                        }.buttonStyle(PlainButtonStyle())
                        NavigationLink(destination: NotificationDetail(productPurchased: self.notificationDataList.list[index].productsPurchased, buyer: self.notificationDataList.list[index].buyer, quantity: self.notificationDataList.list[index].quantities, selectedTransactionProgress: self.notificationDataList.list[index].progressStatus, indexSelected: index)) {
                            NotificationItemView(productPurchased: self.notificationDataList.list[index].productsPurchased, buyer: self.notificationDataList.list[index].buyer, quantity: self.notificationDataList.list[index].quantities)
                        }.buttonStyle(PlainButtonStyle())
                        
                        //EmptyView()
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
            print("masuk onappear")
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
        
//        self.notificationDataList.productsPurchased.removeAll()
//        self.notificationDataList.buyers.removeAll()
//        self.notificationDataList.quantities.removeAll()
        self.notificationDataList.list.removeAll()
        
        let database = CKContainer.default().publicCloudDatabase
        
        let reference = CKRecord.Reference(recordID: userStore.id, action: .deleteSelf)
        
        let predicate = NSPredicate(format: "seller == %@", reference)
        
        let query = CKQuery(recordType: "Transaction", predicate: predicate)
        
        database.perform(query, inZoneWith: nil) { (results, error) in
            if let err = error {
                print(err.localizedDescription)
            }
            
            
            if let results = results {
                print(results)
                //self.filterTransactionByStore(results: results)
                self.parseResult(results: results)
            }
        }
    }
    
    func parseResult(results : [CKRecord]){
        let database = CKContainer.default().publicCloudDatabase
        
        var allQuantitiesList : [Int] = []
        var convertedProductsAll : [ProductPurchasedData] = []
        var buyerList : [BuyerData] = []
        var transactionIDList : [CKRecord.ID] = []
        var statusList : [Int] = []
        
        var productImage : UIImage?
//        var buyer : BuyerData?
        var buyerImage : UIImage?
        
        let dispatchGroup = DispatchGroup()
        
        for index in 0 ..< results.count {
            //transactions.removeAll()
            print("Produk Masuk:")
            
            
            print("Transaksi ke : \(index + 1)")
            
            let record = results[index]
            
            
            //let transactionID = record.recordID
            
            
            let buyerReference = record.value(forKey: "buyer") as! CKRecord.Reference
            
            
            
            let productsPurchasedReferences = record.value(forKey: "productsPurchased") as! [CKRecord.Reference]
            
            let quantities = record.value(forKey: "quantities") as! [Int]
            
            
            
            for index2 in 0 ..< productsPurchasedReferences.count{
                print("Transaksi \(index + 1) Produk \(index2 + 1)")
                let productReference = productsPurchasedReferences[index2]
                
                print("Downloading Transaksi \(index + 1) Produk \(index2 + 1)...")
                

                database.fetch(withRecordID: productReference.recordID) { (result, error) in
                    if let err = error {
                        print(err.localizedDescription)
                    }
                    
                    if let result = result {
                        if let asset = result.value(forKey: "image") as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!){
                            productImage = UIImage(data: data)
                        }
                        
                        let product = ProductPurchasedData(name: result.value(forKey: "name") as! String, description: result.value(forKey: "description") as! String, price: result.value(forKey: "price") as! Int, stock: result.value(forKey: "stock") as! Int, beanType: result.value(forKey: "beanType") as! String, roastType: result.value(forKey: "roastType") as! String, flavour: result.value(forKey: "flavour") as! [String], image: productImage!, id: result.recordID, buyer: buyerReference)
                        
                        
                        print("Download Transaksi \(index + 1) Produk \(index2 + 1) complete")
                        
                        convertedProductsAll.append(product)
                    }
                }
                
                
            }
            //END FOR
            
            //Fetch BuyerData
            print("Downloading data buyer transaksi \(index + 1)")
            dispatchGroup.enter()
            database.fetch(withRecordID: buyerReference.recordID) { (result, error) in
                if let err = error {
                    print(err.localizedDescription)
                }
                
                if let result = result {
                    print("Download data buyer transaksi \(index + 1) complete")
                    if let asset = result.value(forKey: "profilePhoto") as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!){
                        buyerImage = UIImage(data: data)
                    }
                    
                    let buyer = BuyerData(id: result.recordID, name: result.value(forKey: "name") as! String, email: result.value(forKey: "email") as! String, password: result.value(forKey: "password") as! String, phoneNumber: result.value(forKey: "phoneNumber") as! String, profilePhoto: buyerImage!)
                    
                    buyerList.append(buyer)
                    
                    for index2 in 0 ..< quantities.count {
                        allQuantitiesList.append(quantities[index2])
                    }
                    
                    let progressStatus = record.value(forKey: "progressStatus") as! Int
                    statusList.append(progressStatus)
                    transactionIDList.append(record.recordID)
                    
                    if buyerList.count == results.count {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.divideProductsByBuyer(productList: convertedProductsAll, buyerList: buyerList, quantities: allQuantitiesList, idList: transactionIDList, statusList: statusList)
                        }
                    }
                }
            }
            
            

            
            
        }
        
        //Divide product sesuai buyernya
        
        
    }
    
    func divideProductsByBuyer(productList : [ProductPurchasedData], buyerList : [BuyerData], quantities : [Int], idList : [CKRecord.ID], statusList : [Int]){
        var productDividedList : [ProductPurchasedData] = []
        var quantitiesDividedList : [Int] = []
        
        for index in 0 ..< buyerList.count {
            productDividedList.removeAll()
            quantitiesDividedList.removeAll()
            
            for index2 in 0 ..< productList.count{
                if productList[index2].buyer.recordID == buyerList[index].id {
                    productDividedList.append(productList[index2])
                    quantitiesDividedList.append(quantities[index2])
                }
            }
            //END of for index2
            
            let newNotif = NotificationData(transactionID: idList[index], buyer: buyerList[index], productsPurchased: productDividedList, quantities: quantitiesDividedList, progressStatus: statusList[index])
            
            self.notificationDataList.list.append(newNotif)
            
            print("Notif List\n \(self.notificationDataList.list[index].productsPurchased)")
        }
        //END of for index
    }
    
}



    
struct NotificationItemView: View {
    var productPurchased : [ProductPurchasedData]
    var buyer : BuyerData
    var quantity : [Int]
    
    @State var totalQty = 0
=======

struct NotificationView: View {
    var currentCart: Cart = .init()
    
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach (0 ..< currentCart.productList.count, id: \.self) { index in
                    NavigationLink(destination: NotificationDetail()) {
                        NotificationItemView()
                    }.buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
        .background(Image("Background").scaledToFill().edgesIgnoringSafeArea(.all))
        .navigationBarTitle("Notification", displayMode: .inline)
        
    }
}

    
struct NotificationItemView: View {
    var selectedCoffee: ProductData = .init()
    var selectedBuyer: UserData = .init()
    var selectedItemQuantity: Int = 1
    
>>>>>>> origin/calvin
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
<<<<<<< HEAD
                Text("Buyer : \(buyer.name)")
                    .font(.title)
                    .padding([.leading, .bottom], 5.0)
                
                if productPurchased.count > 1{
                    Text("\(productPurchased.first!.name) and \(productPurchased.count - 1) more item")
                    .font(.headline)
                    .padding([.leading, .bottom], 5.0)
                }
                else{
                    Text("\(productPurchased.first!.name)")
                    .font(.headline)
                    .padding([.leading, .bottom], 5.0)
                }
                
//                Text("Total item quantity purchased: \(totalQty)")
//                    .font(.body)
//                    .padding([.leading, .bottom], 5.0)
                
//                Text("Total Item: \(totalQty), Total price: Rp.\(productPurchased.price * quantity),-")
=======
                Text("There is a buyer!")
                    .font(.title)
                    .padding([.leading, .bottom], 5.0)
                Text("\(selectedCoffee.name)")
                    .font(.headline)
                    .padding([.leading, .bottom], 5.0)
                Text("Quantity: \(selectedItemQuantity), Total price: Rp.\(selectedCoffee.price * selectedItemQuantity),-")
                    .font(.body)
                    .padding([.leading, .bottom], 5.0)
>>>>>>> origin/calvin
            }
                .padding([.top, .leading, .bottom], 5.0)
            Spacer()
            Image("WhatsappIcon")
                .resizable()
                .padding(.trailing, 5.0)
                .frame(width: 50.0, height: 50.0)
                .foregroundColor(Color.blue)
                .onTapGesture() {
<<<<<<< HEAD
                    UIApplication.shared.open(URL(string: "https://wa.me/\(self.buyer.phoneNumber)?text=I'm%20interested%20in%20buying%20your%20coffee%20for%20sale")!)
=======
                    UIApplication.shared.open(URL(string: "https://wa.me/\(self.selectedBuyer.number)?text=I'm%20interested%20in%20buying%20your%20coffee%20for%20sale")!)
>>>>>>> origin/calvin
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
<<<<<<< HEAD
            .onAppear(){
                self.calculateTotalQuantity()
        }
    }
    
    func calculateTotalQuantity(){
        for index in 0 ..< quantity.count {
            totalQty += quantity[index]
        }
=======
>>>>>>> origin/calvin
    }
}

struct NotificationDetail: View {
<<<<<<< HEAD
    var productPurchased : [ProductPurchasedData]
    var buyer : BuyerData
    var quantity : [Int]
    @State var selectedTransactionProgress = 1
    var indexSelected : Int
    
    @ObservedObject var notificationDataList : NotificationList = .shared
    
    var body: some View {
        ScrollView(.vertical){
            VStack {
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
=======
    var selectedCoffee: ProductData = .init()
    var selectedBuyer: UserData = .init()
    var selectedItemQuantity: Int = 1
    var selectedTransactionProgress = 1
    
    var body: some View {
        VStack {
            //coffee brief detail
            HStack {
                Image(uiImage: selectedCoffee.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 125.0, height: 125.0)
                    .clipped()
                    .cornerRadius(10.0)
                    .padding()
                VStack(alignment: .leading) {
                    Text("\(selectedCoffee.name)")
                        .font(.title)
                    Text("Quantity  :  \(selectedItemQuantity)")
                        .font(.body)
                    Text("Price        :  \(selectedCoffee.price)")
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
                    Text("\(selectedBuyer.name)")
                        .font(.title)
                    Text("\(selectedBuyer.number)")
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
                        UIApplication.shared.open(URL(string: "https://wa.me/\(self.selectedBuyer.number)?text=I'm%20interested%20in%20buying%20your%20coffee%20for%20sale")!)
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
>>>>>>> origin/calvin
                }
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 1)
                    )
                
<<<<<<< HEAD
                //coffee brief detail
                VStack {
                    ForEach (0 ..< productPurchased.count) { index in
                        HStack {
                            Image(uiImage: self.productPurchased[index].image!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 125.0, height: 125.0)
                                .clipped()
                                .cornerRadius(10.0)
                                .padding()
                            VStack(alignment: .leading) {
                                Text("\(self.productPurchased[index].name)")
                                    .font(.title)
                                Text("Quantity  :  \(self.quantity[index])")
                                    .font(.body)
                                Text("Subtotal        :  \(self.productPurchased[index].price * self.quantity[index])")
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
                        
                    }
                }
                
                
                
                
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
                    Button(action: {
                        self.selectedTransactionProgress = 2
                        
                        //Update the transactionProgress in database
                        self.updateTransactionStatus(newValue: 2)
                    }) {
                        Text("Confirm Order Payment")
                            .foregroundColor(Color.white)
                    }
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 25)
                        .background(Color.blue)
                        .cornerRadius(12.5)
                        .padding(.top)
                    Button(action: {
                        self.selectedTransactionProgress = 3
                        
                        //Update the transactionProgress in database
                        self.updateTransactionStatus(newValue: 3)
                    }) {
                        Text("Item sent")
                            .foregroundColor(Color.white)
                    }
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 25)
                        .background(Color.blue)
                        .cornerRadius(12.5)
                    .padding(.top)
                    Button(action: {
                        self.selectedTransactionProgress = 4
                        
                        //Update the transactionProgress in database
                        self.updateTransactionStatus(newValue: 4)
                    }) {
                        Text("Item Arrived")
                            .foregroundColor(Color.white)
                    }
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 25)
                        .background(Color.blue)
                        .cornerRadius(12.5)
                        .padding(.top)
                }
            }
            
        }
        .padding(.top)
        .background(Image("Background").edgesIgnoringSafeArea(.all))
    }
    
    
    func updateTransactionStatus(newValue : Int){
        let database = CKContainer.default().publicCloudDatabase
        let transactionID = notificationDataList.list[indexSelected].transactionID

        database.fetch(withRecordID: transactionID!) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
            }
            
            guard let record = result else {return}
            record.setValue(newValue, forKey: "progressStatus")
            
            database.save(record) { (result, error) in
                if let err = error {
                    print(err.localizedDescription)
                }
            }
        }
=======
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
>>>>>>> origin/calvin
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
<<<<<<< HEAD


//func filterTransactionByStore(results : [CKRecord]){
//    var productList : [CKRecord.Reference] = []
//    var QuantityList : [Int] = []
//    var buyerList : [CKRecord.Reference] = []
//
//    for index in 0 ..< results.count {
//        let record = results[index]
//
//        let recordSellerList = record.value(forKey: "sellers") as! [CKRecord.Reference]
//
//        let productPurchasedList = record.value(forKey: "productsPurchased") as! [CKRecord.Reference]
//
//        let quantities = record.value(forKey: "quantities") as! [Int]
//
//
//
//        for index2 in 0 ..< recordSellerList.count {
//            let seller = recordSellerList[index2]
//
//            if seller.recordID == userStore.id {
//                productList.append(productPurchasedList[index2])
//                QuantityList.append(quantities[index2])
//                buyerList.append(record.value(forKey: "buyer") as! CKRecord.Reference)
//            }
//        }
//
//
//    }
//
//    loadFilteredTransaction(productList: productList, quantityList: QuantityList, buyerList: buyerList)
//
//
//}
//
//func loadFilteredTransaction(productList: [CKRecord.Reference], quantityList: [Int], buyerList: [CKRecord.Reference]){
//    var productImage : UIImage?
//    var buyerImage : UIImage?
//    let database = CKContainer.default().publicCloudDatabase
//
//    for index in 0 ..< productList.count {
//        let productRecord = productList[index]
//        let buyerRecord = buyerList[index]
//
//        //Masukin product ke list notif
//        database.fetch(withRecordID: productRecord.recordID) { (result, error) in
//            if let err = error {
//                print(err.localizedDescription)
//            }
//            if let result = result {
//                if let asset = result.value(forKey: "image") as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!){
//                    productImage = UIImage(data: data)
//                }
//
//                let product = ProductData(name: result.value(forKey: "name") as! String, description: result.value(forKey: "description") as! String, price: result.value(forKey: "price") as! Int, stock: result.value(forKey: "stock") as! Int, beanType: result.value(forKey: "beanType") as! String, roastType: result.value(forKey: "roastType") as! String, flavour: result.value(forKey: "flavour") as! [String], image: productImage!, id: result.recordID, seller: result.value(forKey: "seller") as! CKRecord.Reference)
//
//                self.notificationDataList.productsPurchased.append(product)
//
//                //Masukin ammount per product
//                self.notificationDataList.quantities.append(quantityList[index])
//            }
//        }
//
//        //Masukin buyer ke list notif
//        database.fetch(withRecordID: buyerRecord.recordID) { (result, error) in
//            if let err = error {
//                print(err.localizedDescription)
//            }
//
//            if let result = result {
//                if let asset = result.value(forKey: "profilePhoto") as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!){
//                    buyerImage = UIImage(data: data)
//                }
//
//                let buyer = BuyerData(id: result.recordID, name: result.value(forKey: "name") as! String, email: result.value(forKey: "email") as! String, password: result.value(forKey: "password") as! String, phoneNumber: result.value(forKey: "phoneNumber") as! String, profilePhoto: buyerImage!)
//
//                self.notificationDataList.buyers.append(buyer)
//
//            }
//        }
//
//
//
//
//    }
//
//
//}
=======
>>>>>>> origin/calvin
