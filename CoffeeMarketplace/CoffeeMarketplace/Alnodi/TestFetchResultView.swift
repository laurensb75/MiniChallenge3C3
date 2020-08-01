//
//  TestFetchResultView.swift
//  CoffeeMarketplace
//
//  Created by Alnodi Adnan on 30/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI
import CloudKit

struct TestFetchResultView: View {
    @Binding var productListConverted : [ProductData]
    @State var selectedProduct = ProductData(name: "", description: "", price: 0, image: UIImage(named: "test"), id: nil)
    @State var isShowingProductDetailView = false
    
    
    @ObservedObject var CKRecordResult : RecordResultRaw = .shared
    @ObservedObject var ConvertedRecordResult : RecordResultConverted = .shared
    
    
    var body : some View{
        VStack{
            NavigationLink(destination: TestProductDetailView(selectedProduct: $selectedProduct, isShowingProductDetailView: $isShowingProductDetailView, productListConverted: $productListConverted), isActive: $isShowingProductDetailView){
                EmptyView()
            }
            
            CoffeeHorizontalCollectionViewB(productListConverted: $productListConverted, selectedProduct: $selectedProduct, isShowingProductDetailView: $isShowingProductDetailView)
        }
        .onAppear(){
            self.fetchAllProduct()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.ConvertedRecordResult.results.append(ProductData(name: "Test", description: "Test", price: 1000, stock: 1, beanType: "Green", roastType: "Dark", flavour: ["1", "2"], image: UIImage(named: "test"), id: nil))
                print("Test sukses")
            }
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
        ConvertedRecordResult.results.removeAll()
        
        for index in 0 ..< CKRecordResult.results.count {
            let record = CKRecordResult.results[index]
            
            if let asset = record.value(forKey: "image") as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!){
                productImage = UIImage(data: data)
            }
            
            print("Product \(index + 1)")
            print("Nama: \(record.value(forKey: "name") as! String)")
            //print(record.recordID)
            
            ConvertedRecordResult.results.append(ProductData(name: record.value(forKey: "name") as! String, description: record.value(forKey: "description") as! String, price: record.value(forKey: "price") as! Int, image: productImage!, id: record.recordID))
            print("Convert Success")
        }
    }
}

struct CoffeeHorizontalCollectionViewB: View {
    var category: String = "Category"
    @Binding var productListConverted : [ProductData]
    @Binding var selectedProduct : ProductData
    @Binding var isShowingProductDetailView : Bool
    
    @ObservedObject var ConvertedRecordResult : RecordResultConverted = .shared
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(category)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .padding(.leading ,10)
            ScrollView(.horizontal, showsIndicators: true){
                HStack{
//                    ForEach(0 ..< productListConverted.count){ index in
//                        CoffeeIconB(coffeeImage: self.productListConverted[index].image, coffeeName: self.productListConverted[index].name, coffeePrice: self.productListConverted[index].price)
//                        .onTapGesture {
//                            print("Product \(index+1) pressed")
//                            self.selectedProduct = ProductData(name: self.productListConverted[index].name, description: self.productListConverted[index].description, price: self.productListConverted[index].price, image: self.productListConverted[index].image, id: self.productListConverted[index].id
//                            )
//                            self.isShowingProductDetailView = true
//                        }
//                    }.padding(.leading, 10)
                    
                    ForEach(0 ..< ConvertedRecordResult.results.count, id: \.self){ index in
                        CoffeeIconB(coffeeImage: self.ConvertedRecordResult.results[index].image, coffeeName: self.ConvertedRecordResult.results[index].name, coffeePrice: self.ConvertedRecordResult.results[index].price)
                        .onTapGesture {
                            print("Product \(index+1) pressed")
                            self.selectedProduct = ProductData(name: self.ConvertedRecordResult.results[index].name, description: self.ConvertedRecordResult.results[index].description, price: self.ConvertedRecordResult.results[index].price, image: self.ConvertedRecordResult.results[index].image, id: self.ConvertedRecordResult.results[index].id
                            )
                            self.isShowingProductDetailView = true
                        }
                    }.padding(.leading, 10)
                }
            }
        }
    }
}

struct CoffeeIconB: View {
    
    var coffeeImage = UIImage(named: "coffee")
    var coffeeName: String = "Coffee Name"
    var coffeePrice: Int = 0
    
    var body: some View {
        ZStack(alignment: .bottomLeading){
            Image(uiImage: coffeeImage!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(
                    width: UIScreen.main.bounds.width * 0.45,
                    height: UIScreen.main.bounds.height * 0.15,
                    alignment: .topLeading
            )
                .clipped()
            VStack(){
                Text(coffeeName)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .padding(.leading,5)
                    .font(.system(size: 20))
                //                Spacer()
                Text("Rp.\(coffeePrice)")
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.trailing)
                    .padding(.trailing,5)
            }
            .frame(width: UIScreen.main.bounds.width * 0.45)
            .background(Color.black.opacity(0.7))
        }
        .cornerRadius(10)
        .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.height * 0.15)
    }
}


//struct TestFetchResultView_Previews: PreviewProvider {
//    @Binding var dummyData : [ProductData] = [ProductData(name: "Kopi A", description: "Ini Kopi A", price: 10000, image: UIImage(systemName: "camera.circle"), id: nil)]
//
//    static var previews: some View {
//        TestFetchResultView(productListConverted: $dummyData)
//    }
//}
