//
//  TestUpdateProductView.swift
//  CoffeeMarketplace
//
//  Created by Alnodi Adnan on 30/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI
import CloudKit

struct TestUpdateProductView: View {
    //    @State var updatedProductData = newProductData(name: "*Nama barang sebelumnya*", description: "*Ini deskripsi sebelumnya*", price: 10000, image: Image(systemName: "camera.circle"))
    @Binding var updatedProductData : ProductData
    @State var isShowingImagePicker = false
    @State var photoPreview : UIImage = UIImage(systemName: "person.fill")!
    
    var body: some View {
        VStack{
            
            if updatedProductData.image != nil{
                Image(uiImage: updatedProductData.image!)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
            }
            else{
                Image(uiImage: photoPreview)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
            }
            
            Text("Tap here to select picture")
                .foregroundColor(.blue)
                .onTapGesture {
                    self.isShowingImagePicker = true
            }
            
            
            HorizontalLine(color: .gray)
            HStack{
                Text("Nama Barang : ")
                TextField(updatedProductData.name, text: $updatedProductData.name)
                    .multilineTextAlignment(.trailing)
            }
            
            HorizontalLine(color: .gray)
            
            HStack{
                Text("Harga Barang sebelumnya : ")
                TextField("", value: $updatedProductData.price, formatter: NumberFormatter())
                    .multilineTextAlignment(.trailing)
            }
            HorizontalLine(color: .gray)
            Text("Deskripsi: ")
                .frame(width: UIScreen.main.bounds.width , alignment: .leading)
            TextView(
                text: $updatedProductData.description
            )
            
            //Spacer()
            Button(action: {
                //print("Update Success")
                self.updateProduct(selectedProduct: self.updatedProductData)
            }) {
                Text("Update Product")
            }
        }
        .sheet(isPresented: $isShowingImagePicker,
               onDismiss: loadImage) {
                ImagePicker(image: self.$photoPreview)
        }
    }
    
    func loadImage(){
        //Ambil image dari newData.profilePhoto
        updatedProductData.image = newData.profilePhoto
    }
    
    func updateProduct(selectedProduct: ProductData){
        let database = CKContainer.default().publicCloudDatabase
        
        let data = updatedProductData.image?.pngData()
        
        let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")
        
        do {
            //try data!.writeToURL(url, options: [])
            try data!.write(to: url!, options: [])
        } catch let e as NSError {
            print("Error! \(e)");
            return
        }
        let updatedProductPhoto = CKAsset(fileURL: url!)
        
        database.fetch(withRecordID: selectedProduct.id) { (record, err) in
            if let err = err{
                print(err.localizedDescription)
            }
            
            guard let record = record else { return }
            record.setValue(self.updatedProductData.name, forKey: "name")
            record.setValue(self.updatedProductData.description, forKey: "description")
            record.setValue(self.updatedProductData.price, forKey: "price")
            record.setValue(updatedProductPhoto, forKey: "image")
            
            //            record["name"] = self.updatedProductData.name
            //            record["description"] = self.updatedProductData.description
            //            record["price"] = self.updatedProductData.price
            //            record["image"] = updatedProductPhoto
            
            database.save(record) { (recordB, error) in
                if let err = error {
                    print(err.localizedDescription)
                }
                
            }
        }
    }
}

//struct TestUpdateProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestUpdateProductView()
//    }
//}
