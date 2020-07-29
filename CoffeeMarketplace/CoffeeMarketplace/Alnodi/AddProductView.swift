//
//  AddProductView.swift
//  CoffeeMarketplace
//
//  Created by Alnodi Adnan on 29/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI
import CloudKit

struct AddProductView: View {
    
    @State var newProduct = newProductData()
    @State var test: String = ""
    @State var photoPreview = Image(systemName: "camera.fill")
    @State var isShowingImagePicker = false
    
    var body: some View {
        VStack{
            ProductNameAndPriceViewB(newProduct: $newProduct)
            Text("Product Description")
            TextView(
                text: $newProduct.description
            )
            .frame(height: 200)
            .padding(10)
            
            Text("Product Image")
            
            if photoPreview == Image(systemName: "camera.fill") {
                photoPreview
                .resizable()
                .frame(width: 150, height: 150)
                .scaledToFit()
            }
            else {
                photoPreview
                .resizable()
                .frame(width: 150, height: 150)
                .scaledToFit()
                .clipShape(Circle())
            }
                
            
            Text("Tap here to select a picture")
                .foregroundColor(.blue)
                .padding()
                .onTapGesture {
                    self.isShowingImagePicker = true
            }
            
            AddProductButton(newProduct: $newProduct)
            
            Spacer()
            
        }
        .background(Image("Background"))
        .sheet(isPresented: $isShowingImagePicker,
        onDismiss: loadImage) {
            ImagePicker(image: self.$newProduct.image)
        }
    }
    
    func loadImage(){
        photoPreview = Image(uiImage: newData.profilePhoto!)
    }
}

struct newProductData {
    var name : String = ""
    var description : String = ""
    var price : Int = 0
    var image = Image("test")
}

struct AddProductButton : View {
    @Binding var newProduct : newProductData
    
    var body: some View {
        Button (action: {
            self.saveProductToCloudKit()
        }) {
            Text("Add Product")
                .padding()
                .frame(width: UIScreen.main.bounds.width - 60)
                .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0))
        }
        .background(Color(red: 0.511, green: 0.298, blue: 0.001))
        .cornerRadius(10)
        .padding(.top, 15)
    }
    
    func saveProductToCloudKit(){
        //Insert data ke cloudkit
        
        //1.Buat dulu recordnya
        let newRecord = CKRecord(recordType: "Product")
        
        //Saving image
        //let data = UIImage(named: "Background1")!.pngData()
        let data = newData.profilePhoto?.pngData()// UIImage -> NSData, see also UIImageJPEGRepresentation
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
        newRecord.setValue(newProduct.name, forKey: "name")
        newRecord.setValue(newProduct.description, forKey: "description")
        newRecord.setValue(newProduct.price, forKey: "price")
        newRecord.setValue(productPhoto, forKey: "image")
        
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

struct ProductNameAndPriceViewB: View {
    
    @Binding var newProduct : newProductData
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .frame(width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.height*0.15).foregroundColor(SellerConstant.lightBrown).addBorder(Color.black, cornerRadius: 15)
            VStack{
                TextField("Product Name", text: $newProduct.name).padding(10).background(SellerConstant.lightBrown)
                Divider()
                HStack{
                    Text("Product Price : ")
                    TextField("Price", value: $newProduct.price, formatter: NumberFormatter()).padding(10).background(SellerConstant.lightBrown).keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                }
                .padding(10)
            }.padding(.horizontal, UIScreen.main.bounds.width*0.075)
            
        }
    }
}


struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
