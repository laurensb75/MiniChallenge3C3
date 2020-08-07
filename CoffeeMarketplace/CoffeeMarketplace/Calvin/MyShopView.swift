//
//  MyShopView.swift
//  myShop-test
//
//  Created by Calvin Dalenta on 21/07/20.
//  Copyright © 2020 Apple Academy. All rights reserved.
//

import SwiftUI
import CloudKit

struct CoffeeData{
    var name: String
    var price: String
    var coffeeImage: Image
}

let testData: [CoffeeData] = [
    CoffeeData(name: "Coffee 1", price: "1", coffeeImage: Image(systemName: "cart")),
    CoffeeData(name: "Coffee 2", price: "2", coffeeImage: Image(systemName: "cart")),
    CoffeeData(name: "Coffee 3", price: "3", coffeeImage: Image(systemName: "cart")),
    CoffeeData(name: "Coffee 4", price: "4", coffeeImage: Image(systemName: "cart")),
    CoffeeData(name: "Coffee 5", price: "5", coffeeImage: Image(systemName: "cart")),
    CoffeeData(name: "Coffee 6", price: "6", coffeeImage: Image(systemName: "cart")),
    CoffeeData(name: "Coffee 7", price: "7", coffeeImage: Image(systemName: "cart")),
    CoffeeData(name: "Coffee 8", price: "8", coffeeImage: Image(systemName: "cart")),
    CoffeeData(name: "Coffee 9", price: "9", coffeeImage: Image(systemName: "cart")),
    CoffeeData(name: "Coffee 10", price: "10", coffeeImage: Image(systemName: "cart")),
    CoffeeData(name: "Coffee 11", price: "11", coffeeImage: Image(systemName: "cart"))
]

struct MyShopView: View {
    @ObservedObject var ConvertedRecordResult : RecordResultConverted = .shared
    @ObservedObject var CKRecordResult : RecordResultRaw = .shared
    @ObservedObject var userStore : ShopData = .shared
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            if ConvertedRecordResult.results.isEmpty{
                Text("Add New Product").padding(50)
            } else {
                //MyShopItemList(coffeeList: testData)
                MyShopItemList(coffeeList: ConvertedRecordResult.results).padding(.top, 20)
            }
        }.navigationBarTitle("\(userStore.name)", displayMode: .inline).navigationBarItems(trailing: Button(action: {}, label: {
            HStack{
                NavigationLink(destination: NotificationView()) {
                    Image(systemName: "bell.fill").foregroundColor(SellerConstant.darkBrown).font(Font.custom("", size: 24))
                }.padding(.trailing, 20)
                NavigationLink(destination: AddItemView()) {
                    Image(systemName: "plus").foregroundColor(SellerConstant.darkBrown).font(Font.custom("", size: 24))
                }
            }})).background(Image("Background"))
            .onAppear(){
                self.fetchAllProduct()
        }
        
        
    }
    
    func fetchShopItem(){
        // Setup
        let pred = NSPredicate(format: "shopID", "someshopID")
        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        
        let query = CKQuery(recordType: "Product", predicate: pred)
        query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        
        operation.recordFetchedBlock = { record in
            DispatchQueue.main.async {
                // Do something to the data fetched
            }
        }
        
        operation.queryCompletionBlock = {(_, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print(err)
                    return
                }
            }
        }
        
        // Execute
        CKContainer.default().publicCloudDatabase.add(operation)
        
    }
    
    func fetchAllProduct(){
        CKRecordResult.results.removeAll()
        //fetch data dari cloudkit
        //1.Tunjuk database yang mau di fetch
        let database = CKContainer.default().publicCloudDatabase
        //print("Records Fetched")
        //2.Menentukan record yang mau di fetch
        let reference = CKRecord.Reference(recordID: userStore.id, action: .deleteSelf)
        let predicate = NSPredicate(format: "seller == %@", reference)
        let query = CKQuery(recordType: "Product", predicate: predicate)
        
        
        //3.Execute query
        database.perform(query, inZoneWith: nil) { records, error in
            if let fetchedRecords = records { //kalo misal record yang diambil tidak empty
                print(fetchedRecords)
                self.CKRecordResult.results = fetchedRecords
                print("Fetch Succcess")
                
                
                DispatchQueue.main.async {
                    print(self.CKRecordResult.results)
                    self.convertRecords()
                }
            }
            
        }
        
    }
    
    func convertRecords(){
        var productImage : UIImage?
        ConvertedRecordResult.results.removeAll()
        
        for index in 0 ..< CKRecordResult.results.count {
            let record = CKRecordResult.results[index]
            
            if let asset = record.value(forKey: "image") as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!){
                productImage = UIImage(data: data)
            }
            
            print("Product \(index + 1)")
            print("Nama: \(record.value(forKey: "name") as! String)")
            //print(record.recordID)
            
            ConvertedRecordResult.results.append(ProductData(name: record.value(forKey: "name") as! String, description: record.value(forKey: "description") as! String, price: record.value(forKey: "price") as! Int, stock: record.value(forKey: "stock") as! Int, beanType: record.value(forKey: "beanType") as! String, roastType: record.value(forKey: "roastType") as! String, flavour: record.value(forKey: "flavour") as! [String], image: productImage!, id: record.recordID))
        }
    }
    
    
}

struct MyShopItemList: View{
    //    var processedCoffeeList: [[CoffeeData]] = []
    var processedCoffeeList: [[ProductData]] = []
    @State var selectedProduct : ProductData = .init()
    //    init(coffeeList: [CoffeeData]) {
    //        processedCoffeeList = coffeeList.chunked(into: coffeeList.count/(coffeeList.count/2))
    //    }
    
    init(coffeeList: [ProductData]) {
        if !coffeeList.isEmpty && coffeeList.count > 2 {
            let itemPerRow = UIScreen.main.bounds.width / 175
            processedCoffeeList = coffeeList.chunked(into: Int(itemPerRow))
        }
    }
    
    var body: some View{
        VStack(alignment: .leading){
            ForEach(processedCoffeeList.indices, id: \.self){i in
                MyShopItemListB(processedCoffeeList: self.processedCoffeeList, indexI: i, selectedProduct: self.$selectedProduct)
            }
        }
    }
    
    
    
}

struct MyShopItemListB: View {
    var processedCoffeeList: [[ProductData]] = []
    var indexI : Int = 0
    @Binding var selectedProduct : ProductData
    @State var isShowingProductDetailView = false
    
    var body: some View{
        HStack{
            NavigationLink(destination: ProductDetail( selectedProduct: selectedProduct), isActive: $isShowingProductDetailView){
                EmptyView()
            }
            
            ForEach(0..<self.processedCoffeeList[indexI].count, id: \.self){j in
                MyShopItem(name: self.processedCoffeeList[self.indexI][j].name, coffeePrice: "Rp\(self.processedCoffeeList[self.indexI][j].price),-", coffeeImage: self.processedCoffeeList[self.indexI][j].image!).padding(5)
                    .onTapGesture {
                        self.selectedProduct = self.processedCoffeeList[self.indexI][j]
                        self.isShowingProductDetailView = true
                }
            }
        }
    }
}

struct MyShopItem: View{
    
    var name: String
    var coffeePrice: String
    //var coffeeImage: Image
    var coffeeImage: UIImage
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            ZStack{
                RoundedRectangle(cornerRadius: 15).foregroundColor(SellerConstant.lightBrown).addBorder(Color.black, width: 1, cornerRadius: 15).frame(width: 175, height: 250)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Rectangle().foregroundColor(Color(red: 216/255, green: 216/255, blue: 216/255)).overlay(
                        Image(uiImage: coffeeImage)
                            .resizable()
                        )
                    
                    
                    VStack(alignment: .leading) {
                        Text(name)
                            .lineLimit(1)
                        Text(coffeePrice)
                            .lineLimit(1)
                    }
                    .padding(12)
                    
                }
                .background(Color.white)
                .cornerRadius(15)
                .addBorder(Color.black, width: 0.5, cornerRadius: 15)
                .frame(width: 150, height: 220)
            }
        }
    }
}

struct MyShopView_Previews: PreviewProvider {
    static var previews: some View {
        MyShopView()
    }
}

extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        return overlay(RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(content, lineWidth: width))
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}


//    var body: some View{
//        VStack(alignment: .leading){
//            ForEach(processedCoffeeList.indices){i in
//                HStack{
//                    ForEach(0..<self.processedCoffeeList[i].count, id: \.self){j in
//                        MyShopItem(name: self.processedCoffeeList[i][j].name, coffeePrice: "Rp\(self.processedCoffeeList[i][j].price),-", coffeeImage: self.processedCoffeeList[i][j].coffeeImage).padding(5)
//                    }
//                }
//            }
//        }
//    }
