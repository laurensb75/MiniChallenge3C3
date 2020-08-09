//
//  DashboardView.swift
//  CoffeeMarketplace
//
//  Created by Laurens Bryan Cahyana on 17/07/20.
//  Copyright ©️ 2020 laurens bryan. All rights reserved.
//

import SwiftUI
import CloudKit

struct DashboardView: View {
    
    @State private var searchText : String = ""
    
//     var defaultProductData = ProductData(name: "Coffee Name", description: "This is coffee description", price: 0, stock: 1, beanType: "green", roastType: "dark", flavour: ["1", "2"], image: UIImage(named: "Coffee"), id: nil)
    
    
    
    var trendingCoffee: [Coffeee] = [
        .init(id: "1", name: "Trending Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "2", name: "Trending Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 110000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "3", name: "Trending Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 150000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "4", name: "Trending Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 125000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Trending Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 375000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    ]
    
    var newCoffee: [Coffeee] = [
        .init(id: "6", name: "New Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 300000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "7", name: "New Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 500000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "8", name: "New Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 500000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
         .init(id: "9", name: "New Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 700000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "10", name: "New Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 500000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    ]
    
    var greenBeansCoffee: [Coffeee] = [
        .init(id: "5", name: "Green Beans Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 200000, roastLevel: 0, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Green Beans Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 300000, roastLevel: 0, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Green Beans Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 400000, roastLevel: 0, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Green Beans Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 0, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Green Beans Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 800000, roastLevel: 0, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    ]
    
    var lightRoastCoffee: [Coffeee] = [
        .init(id: "5", name: "Light Roast Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Light Roast Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 400000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Light Roast Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Light Roast Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 500000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Light Roast Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 600000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    ]
    
    var mediumRoastCoffee: [Coffeee] = [
        .init(id: "5", name: "Medium Roast Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 400000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Medium Roast Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Medium Roast Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 700000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Medium Roast Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Medium Roast Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 500000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    ]
    
    var darkRoastCoffee: [Coffeee] = [
        .init(id: "5", name: "Dark Roast Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Dark Roast Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 400000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Dark Roast Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Dark Roast Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 200000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Dark Roast Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 400000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    ]
    
    @ObservedObject var CKRecordResult : RecordResultRaw = .shared
    @ObservedObject var ConvertedRecordResult : RecordResultConverted = .shared
    @State var isShowingCartView = false
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: CartView(), isActive: $isShowingCartView){
                    EmptyView()
                }
                
                HStack{
                    SearchBar(text: $searchText)
                        .frame(height: UIScreen.main.bounds.height * 0.05)
                        .padding(.leading, 5)
                    Button(action: {
                        
                    }) {
                        Image("FilterIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width * 0.07)
                    }
                        .foregroundColor(Color.black)
                        .padding(.trailing, 15.0)
                    .navigationBarTitle("Market", displayMode: .inline)
                    
                    Button(action: {
                        print("Refreshing...")
                        self.fetchAllProduct()
                    }) {
                        Image(systemName: "arrow.clockwise")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.07)
                    }
                        .foregroundColor(Color.black)
                        .padding(.trailing, 15.0)
                }
                //display item in category
                ScrollView(.vertical, showsIndicators: true){
                    CoffeeHorizontalCollectionViewC(productsInCategory: ConvertedRecordResult.results, category: "All Product")
                    .padding(5)
                    //CoffeeHorizontalCollectionView(coffeeInCategory: trendingCoffee, category: "Trending")
                        //.padding([.leading, .bottom, .trailing], 5)
                    //CoffeeHorizontalCollectionView(coffeeInCategory: newCoffee, category: "New")
                        //.padding(5)
                    CoffeeHorizontalCollectionViewC(productsInCategory: self.getGreenBeanProducts(), category: "Green Beans")
                        .padding(5)
                    CoffeeHorizontalCollectionViewC(productsInCategory: self.getProductByRoastType(roastType: "Light"), category: "Light Roast")
                        .padding(5)
                    CoffeeHorizontalCollectionViewC(productsInCategory: self.getProductByRoastType(roastType: "Medium"), category: "Medium Roast")
                    .padding(5)
                    CoffeeHorizontalCollectionViewC(productsInCategory: self.getProductByRoastType(roastType: "Dark"), category: "Dark Roast")
                    .padding(5)
                    
                }
            }.background(Image("Background").resizable().edgesIgnoringSafeArea(.all).scaledToFill().edgesIgnoringSafeArea(.all))
            .navigationBarItems(trailing:
                Button(action: {
                    
                }) {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                }
            )
        }
            .onTapGesture {UIApplication.shared.endEditing()}
            .navigationBarTitle("Market", displayMode: .inline)
            
            .onAppear(){
                self.fetchAllProduct()
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
            
//            print("Product \(index + 1)")
//            print("Nama: \(record.value(forKey: "name") as! String)")
//            print("Roasttype: \(record.value(forKey: "roastType") as! String)")
            //print(record.recordID)
            
            ConvertedRecordResult.results.append(ProductData(name: record.value(forKey: "name") as! String, description: record.value(forKey: "description") as! String, price: record.value(forKey: "price") as! Int, stock: record.value(forKey: "stock") as! Int, beanType: record.value(forKey: "beanType") as! String, roastType: record.value(forKey: "roastType") as! String, flavour: record.value(forKey: "flavour") as! [String], image: productImage!, id: record.recordID))
            
        }
        print("Convert Success")
    }
    
    func getGreenBeanProducts() -> [ProductData]{
        var result : [ProductData] = []
        
        for index in 0 ..< ConvertedRecordResult.results.count {
            let product = ConvertedRecordResult.results[index]
            
            if product.beanType == "Green"{
                result.append(product)
            }
        }
        
        print("Convert Green Bean Product Success")
        return result
    }
    
    func getProductByRoastType(roastType: String) -> [ProductData]{
        var result : [ProductData] = []
        
        for index in 0 ..< ConvertedRecordResult.results.count {
            let product = ConvertedRecordResult.results[index]
            
            if product.roastType == roastType{
                result.append(product)
            }
        }
        
        print("Convert \(roastType) Product Success")
        return result
    }
}

struct CoffeeHorizontalCollectionView: View {
    var coffeeInCategory: [Coffeee]
    
    var category: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(category)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .padding(.leading ,10)
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(0 ..< 5){ index in
                        NavigationLink(destination: ProductDetail(selectedCoffee: self.coffeeInCategory[index])){
                            CoffeeIcon(coffeeToDisplay: self.coffeeInCategory[index]).opacity(1)
                        }
                            .buttonStyle(PlainButtonStyle())
                    }
                }.padding(.leading, 10)
            }.frame(height: 100)
        }
    }
}

struct CoffeeHorizontalCollectionViewC: View {
    var defaultSelectedCoffee = Coffeee(id: "0", name: "Coffee Name", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 0, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    
         var defaultProductData = ProductData(name: "Coffee Name", description: "This is coffee description", price: 0, stock: 1, beanType: "green", roastType: "dark", flavour: ["1", "2"], image: UIImage(named: "Coffee"), id: nil)
    
    var productsInCategory: [ProductData]
    
    var category: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(category)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .padding(.leading ,10)
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    if productsInCategory.isEmpty{
                        //Text("Empty")
                        CoffeeIconC(productToDisplay: defaultProductData)
                    }
                    else{
                        ForEach(0 ..< productsInCategory.count, id: \.self){ index in
                            NavigationLink(destination: ProductDetail(selectedCoffee: self.defaultSelectedCoffee, selectedProduct: self.productsInCategory[index])){
                                CoffeeIconC(productToDisplay: self.productsInCategory[index]).opacity(1)
                            }
                                .buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                }.padding(.leading, 10)
            }.frame(height: 100)
        }
    }
}


struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
