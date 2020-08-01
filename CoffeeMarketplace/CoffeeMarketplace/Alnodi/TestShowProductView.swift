//
//  TestShowProductView.swift
//  CoffeeMarketplace
//
//  Created by Alnodi Adnan on 29/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI
import CloudKit

struct TestShowProductView: View {
    @State var productRecordList : [CKRecord] = []
    @State var isShowingHasilFetch = false
    @State var productRecordsConverted : [ProductData] = []
    @State var isShowingCartView = false
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: TestFetchResultView(productListConverted: $productRecordsConverted), isActive: $isShowingHasilFetch){
                    EmptyView()
                }
                
                NavigationLink(destination: TestCartView(), isActive: $isShowingCartView){
                    EmptyView()
                }
                
                Button(action: {
                    //self.fetchAllProduct()
                    //DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                        self.isShowingHasilFetch = true
                    //}
                }) {
                    Text("fetch data")
                }
                
//                Button(action: {
//                    //self.convertRecords()
//                    self.isShowingHasilFetch = true
//                }) {
//                    Text("Print records result")
//                }
                
                Button(action: {
                    self.isShowingCartView = true
                }) {
                    Text("Go to cart view")
                }
            }
        }
        
        
    }
    
    func fetchAllProduct(){
        productRecordList.removeAll()
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
                self.productRecordList = fetchedRecords
                print("Fetch Succcess")
                
                
                DispatchQueue.main.async {
                    print(self.productRecordList)
                    self.convertRecords()
                }
            }
            
        }
        
    }
    
    func convertRecords(){
        var productImage : UIImage?
        productRecordsConverted.removeAll()
        
        for index in 0 ..< productRecordList.count {
            let record = productRecordList[index]
            
            if let asset = record.value(forKey: "image") as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!){
                productImage = UIImage(data: data)
            }
            
            print("Product \(index + 1)")
            print("Nama: \(record.value(forKey: "name") as! String)")
            //print(record.recordID)
            
            productRecordsConverted.append(ProductData(name: record.value(forKey: "name") as! String, description: record.value(forKey: "description") as! String, price: record.value(forKey: "price") as! Int, image: productImage!, id: record.recordID))
            print("Convert Success")
        }
    }
}


struct TestShowProductView_Previews: PreviewProvider {
    static var previews: some View {
        TestShowProductView()
    }
}

