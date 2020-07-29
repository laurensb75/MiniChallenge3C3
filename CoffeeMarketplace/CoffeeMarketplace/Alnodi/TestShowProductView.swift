//
//  TestShowProductView.swift
//  CoffeeMarketplace
//
//  Created by Alnodi Adnan on 29/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI
import CloudKit

struct HasilFetch: View {
    @Binding var productList : [CKRecord]
    @State var record : CKRecord!
    
    var body : some View{
        VStack{
            ForEach(0 ..< productList.count) { index in
                //record = productList[index]
                Text("ABC")
            }
        }
    }
}

struct TestShowProductView: View {
    
    @State var productList : [CKRecord] = []
    @State var isShowingHasilFetch = false
    
    var body: some View {
        NavigationView{
            VStack{
                CoffeeHorizontalCollectionViewB(productListResult: $productList)
                
                NavigationLink(destination: HasilFetch(productList: $productList), isActive: $isShowingHasilFetch){
                    EmptyView()
                }
                
                Button(action: {
                    self.fetchAllProduct()
                }) {
                    Text("fetch data")
                }
                
                Button(action: {
                    self.printRecords()
                    self.isShowingHasilFetch = true
                }) {
                    Text("Print records result")
                }
            }
        }
        

    }
    
    func fetchAllProduct(){
        //fetch data dari cloudkit
        //1.Tunjuk database yang mau di fetch
        let database = CKContainer.default().publicCloudDatabase
        //print("Records Fetched")
        //2.Menentukan record yang mau di fetch
        //let predicate = NSPredicate(format: "email = %@ AND password = %@", argumentArray: [newLogin.email, newLogin.password])
        let predicate = NSPredicate(value: true) //Ngambil semua record dari querynya, tidak di filter
        let query = CKQuery(recordType: "Product", predicate: predicate)
        
        //3.Execute query
        database.perform(query, inZoneWith: nil) { records, error in
            if let fetchedRecords = records { //kalo misal record yang diambil tidak empty
                print(fetchedRecords)
                self.productList = fetchedRecords
                
//                if let asset = fetchedRecords.first?.value(forKey: "profilePhoto") as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!){
//                    userLoggedOn.profilePhoto = UIImage(data: data)
//                }
                
                DispatchQueue.main.async {
                    print(self.productList)
                }
            }

        }
        
    }
    
    func printRecords(){
        for index in 0 ..< productList.count {
            let record = productList[index]
            
            print("Product \(index + 1)")
            print("Nama: \(record.value(forKey: "name") as! String)")
            //print(record.recordID)
        }

    }
}

struct CoffeeHorizontalCollectionViewB: View {
    var category: String = "Category"
    @Binding var productListResult : [CKRecord]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(category)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .padding(.leading ,10)
            ScrollView(.horizontal, showsIndicators: true){
                HStack{
//                    if productListResult != nil{
                        ForEach(0 ..< 5){ index in
                            CoffeeIcon(coffeeImage: "Coffee", coffeeName: "Bewitched", coffeePrice: 250000)
                        }
//                    }
//                    ForEach(0 ..< productListResult.count, id: \.self){ index in
//                        Text("abc")
//                    }
                    
                }.padding(.leading, 10)
            }
        }
    }
}

struct CoffeeIconB: View {
    
    var coffeeImage: String = "Coffee"
    var coffeeName: String = "Coffee Name"
    var coffeePrice: Int = 0
    
    var body: some View {
        ZStack(alignment: .bottomLeading){
            Image(coffeeImage)
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

struct TestShowProductView_Previews: PreviewProvider {
    static var previews: some View {
        TestShowProductView()
    }
}
