//
//  AddItemView.swift
//  myShop-test
//
//  Created by Calvin Dalenta on 21/07/20.
//  Copyright © 2020 Apple Academy. All rights reserved.
//

import SwiftUI
import CloudKit

struct AddItemView: View {
    
    @State var productName: String = ""
    @State var productPrice: String = ""
    
    @State var stockNumber: Int = 1
    @State var productDescription: String = ""
    @State var productImage: UIImage = UIImage(systemName: "plus.circle")!
    
    @State var beanTypeSelected: String = ""
    @State var roastTypeSelected: String = ""
    @State var flavourSelected: [String] = []
    
    @State private var showingAlert = false
    
    var body: some View {
            VStack{
                ProductNameAndPriceView(productTextField: $productName, priceTextField: $productPrice).padding(.vertical, 20)
                
                ProductDetailView(stockNum: $stockNumber, productDescription: $productDescription, productImage: $productImage)
                
                CoffeeTypeView(beanTypeSelected: $beanTypeSelected, roastTypeSelected: $roastTypeSelected, flavourSelected: $flavourSelected).padding(.vertical, 20)
                
                Spacer()
            }.background(SellerConstant.mainBackground).navigationBarTitle("Add Item", displayMode: .inline).navigationBarItems(trailing: Button (action: {
                self.saveProductToCloudKit()
            }) {
                Text("Add")
                    .foregroundColor(SellerConstant.darkBrown)
                }).alert(isPresented: $showingAlert) {
                    Alert(title: Text("All Fields Required"), message: Text("All fields need to be filled"), dismissButton: .default(Text("OK")))
                }
    }
    
    // Refer ke codenya arnoldi dengan tambahan sedikit
    func saveProductToCloudKit(){
        
        if productName.isEmpty || productPrice.isEmpty || stockNumber <= 0 || productDescription.isEmpty || beanTypeSelected.isEmpty || roastTypeSelected.isEmpty || flavourSelected.isEmpty {
            //Error handling here
            showingAlert.toggle()
            return
        }
        
        //Insert data ke cloudkit
        
        //1.Buat dulu recordnya
        let newRecord = CKRecord(recordType: "Product")

        //Saving image
        //let data = UIImage(named: "Background1")!.pngData()
        let data = newData.profilePhoto?.pngData()//
        //let data2 = Image(UIImage)
        
        let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")

        do {
            //try data!.writeToURL(url, options: [])
            try data!.write(to: url!, options: [])
        } catch let e as NSError {
            print("Error! \(e)");
            return
        }
        let productPhoto = CKAsset(fileURL: url!)
        
        

        //2.Set property
        newRecord.setValue(productName, forKey: "name")
        newRecord.setValue(Int(productPrice), forKey: "price")
        newRecord.setValue(stockNumber, forKey: "stock")
        newRecord.setValue(productDescription, forKey: "description")
        newRecord.setValue(productPhoto, forKey: "image")
        newRecord.setValue(beanTypeSelected, forKey: "beanType")
        newRecord.setValue(roastTypeSelected, forKey: "roastType")
        newRecord.setValue(flavourSelected, forKey: "flavour")

        //3.Execute save or insert
        let database = CKContainer.default().publicCloudDatabase
        database.save(newRecord) { record, error in
            if let err = error {
                print(err.localizedDescription)
            }

            print(record)

            DispatchQueue.main.async {
                //Update UI
            }

        }
    }
}

struct ProductNameAndPriceView: View {
    
    @Binding var productTextField: String
    @Binding var priceTextField: String
    
    @Environment (\.defaultMinListRowHeight) var rowHeight

    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 15).frame(width: UIScreen.main.bounds.width*0.9, height: rowHeight * 2).foregroundColor(SellerConstant.lightBrown).addBorder(Color.black, cornerRadius: 15)
            VStack{
                TextField("Product Name", text: $productTextField).padding(10).background(SellerConstant.lightBrown).frame(height: rowHeight / 2)
                Divider()
                TextField("Price", text: $priceTextField).padding(10).background(SellerConstant.lightBrown).keyboardType(.numberPad).frame(height: rowHeight / 2)
            }.padding(.horizontal, UIScreen.main.bounds.width*0.075)
        }
    }
}

struct ProductDetailView: View {
    
    @Binding var stockNum: Int
    @Binding var productDescription: String
    @Binding var productImage: UIImage
    
    @Environment (\.defaultMinListRowHeight) var rowHeight
    
    @State var pickerVisible: Bool = false

    var body: some View{
        
        //TODO: Disable Scrolling Behaviour on List
        RoundedRectangle(cornerRadius: 15).frame(width: UIScreen.main.bounds.width*0.9, height: self.pickerVisible ? UIScreen.main.bounds.height*0.4: rowHeight * 3).foregroundColor(.white)
            .overlay(
                        List {
                            HStack{
                                Text("Stock")
                                Spacer()
                                Button("\(stockNum)"){
                                    self.pickerVisible.toggle()
                                }.foregroundColor(.secondary)
                            }
                            
                            if pickerVisible{
                                HStack{
                                    Spacer()
                                    Picker(selection: $stockNum, label: Text("")){
                                        ForEach(1..<101){index in
                                            Text("\(index-1)")
                                        }
                                    }
                                    .onTapGesture {
                                        self.pickerVisible.toggle()
                                    }
                                    Spacer()
                                }.animation(.easeIn(duration: 0.1))
                            }
                            
                            NavigationLink(destination: AddItem_ProductDescription_View(descriptionTextField: $productDescription)){
                                Text("Product Description")
                            }
                            NavigationLink(destination: AddItem_ProductImage_View(currentImage: $productImage))
                            {
                                Text("Product Image")
                            }
                            }.colorMultiply(SellerConstant.lightBrown).cornerRadius(15).addBorder(Color.black, cornerRadius: 15)
        ).animation(.easeIn(duration: 0.1))
    }
}

struct CoffeeTypeView: View{
    
    @Binding var beanTypeSelected: String
    @Binding var roastTypeSelected: String
    @Binding var flavourSelected: [String]
    
    @Environment (\.defaultMinListRowHeight) var rowHeight

    var body: some View{
        //TODO: Disable Scrolling Behaviour on List
        VStack{
            RoundedRectangle(cornerRadius: 15).frame(width: UIScreen.main.bounds.width*0.9, height: rowHeight * 3).foregroundColor(Color.init(red: 251/255, green: 245/255, blue: 235/255)).overlay(
                List {
                    NavigationLink(destination: AddItem_BeanType_View(selections: $beanTypeSelected)){
                        Text("Bean Type")
                        Spacer()
                        Text("\(beanTypeSelected)").foregroundColor(Color.secondary).lineLimit(1)
                    }
                    NavigationLink(destination: AddItem_RoastType_View(selections: $roastTypeSelected)){
                        Text("Roast Type")
                        Spacer()
                        Text("\(roastTypeSelected)").foregroundColor(Color.secondary).lineLimit(1)
                    }
                    NavigationLink(destination: AddItem_Flavour_View(selections: $flavourSelected)){
                        Text("Flavour")
                        Spacer()
                    }
            }).colorMultiply(SellerConstant.lightBrown).cornerRadius(15).addBorder(Color.black, cornerRadius: 15)
        }
        
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
