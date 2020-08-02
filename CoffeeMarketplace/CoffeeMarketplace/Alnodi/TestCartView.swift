//
//  TestCartView.swift
//  CoffeeMarketplace
//
//  Created by Alnodi Adnan on 30/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI
import CloudKit

struct TestCartView: View {
    
    @ObservedObject var cart : Cart = .shared
    @ObservedObject var CKRecordResult : RecordResultRaw = .shared
    
    var body: some View {
        VStack{
            if cart.productList.isEmpty {
                Text("No item")
            }
            else{
                ForEach(0 ..< cart.productList.count, id: \.self) {index in
                    VStack{
                        Text("index : \(index)")
                        cartItem(product: self.cart.productList[index], indexSelected: index)
                    }
                }
            }
            Spacer()
        }
        .onAppear(){
            self.fetchAllProduct()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                self.cart.productList.append(ProductData(name: "Test", description: "Test", price: 1000, stock: 1, beanType: "Green", roastType: "Dark", flavour: ["1", "2"], image: UIImage(named: "test"), id: nil))
//                print("Test sukses")
//            }
        }
    }
    
    
    func fetchAllProduct(){
        CKRecordResult.results.removeAll()
        //fetch data dari cloudkit
        //1.Tunjuk database yang mau di fetch
        let database = CKContainer.default().publicCloudDatabase
        //print("Records Fetched")
        //2.Menentukan record yang mau di fetch
        let predicate = NSPredicate(value: true) //Ngambil semua record dari querynya, tidak di filter
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
        cart.productList.removeAll()
        
        for index in 0 ..< CKRecordResult.results.count {
            let record = CKRecordResult.results[index]
            
            if let asset = record.value(forKey: "image") as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!){
                productImage = UIImage(data: data)
            }
            
            print("Product \(index + 1)")
            print("Nama: \(record.value(forKey: "name") as! String)")
            //print(record.recordID)
            
            cart.productList.append(ProductData(name: record.value(forKey: "name") as! String, description: record.value(forKey: "description") as! String, price: record.value(forKey: "price") as! Int, image: productImage!, id: record.recordID))
            print("Convert Success")
        }
    }
}

struct cartItem: View{
    @State var qty = 0
    var product : ProductData
    var indexSelected : Int
    
    @ObservedObject var cart : Cart = .shared
    
    var body : some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.15)
                .foregroundColor(.gray)
            
            HStack{
//                Image(systemName: "camera.circle")
//                    .resizable()
//                    .frame(width:100, height: 100)
//                    .clipShape(Circle())
                Image(uiImage: product.image!)
                    .resizable()
                    .frame(width:100, height: 100)
                    .clipShape(Circle())
                
                VStack(alignment: .leading){
                    Text(product.name)
                    Text("Rp. \(product.price)")
                    HStack{
                        Stepper(value: $qty, in: 1...100){
                            Text("Qty : \(qty)")
                        }
                    }
                    .frame(width: 170)
                }
                .padding(.horizontal, 10.0)
                
                Button(action: {
                    print("deleted item at index: \(self.indexSelected)")
                    self.cart.productList.remove(at: self.indexSelected)
                }) {
                    Image(systemName: "trash.fill")
                    .resizable()
                    .frame(width: 30, height: 35)
                }
                
            }
        }
        
    }
}

struct TestCartView_Previews: PreviewProvider {
    static var previews: some View {
        TestCartView()
    }
}

