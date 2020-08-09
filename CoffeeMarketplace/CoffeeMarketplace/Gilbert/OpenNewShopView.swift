//
//  OpenNewShopView.swift
//  CoffeeMarketplace
//
//  Created by Alnodi Adnan on 04/08/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI
import CloudKit

enum ModalView {
    case ownerValidID
    case storeLogo
}

struct OpenNewShopView: View {
    @State var newShopName : String = ""
    @State var newShopAddress : String = ""
    @State var newShopOwnerID : UIImage = UIImage(systemName: "plus.circle")!
    @State var newShopLogo : UIImage = UIImage(systemName: "plus.circle")!
    @State var isShowingImagePicker = false
    @State var imagePickerState : ModalView = .ownerValidID
    
    var imagePlaceholder = Image(systemName: "plus.circle")
    
    @ObservedObject var userLoggedOn : userData = .shared
    @ObservedObject var UserStore : ShopData = .shared
    
    var body: some View {
        ScrollView(.vertical){
            ZStack{
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.9)
                    .foregroundColor(SellerConstant.lightBrown)
                    .border(Color.black, width: 1)
                
                VStack(alignment: .leading){
                    Text("Shop Name")
                        .font(.system(size: 24, weight: .bold))
                    
                    TextField("Shop Name", text: $newShopName)
                        .padding(.horizontal, 10.0)
                    HorizontalLine(color: .gray)
                        .padding(.horizontal, 10.0)
                    
                    Text("Shop Address")
                        .font(.system(size: 24, weight: .bold))
                    
                    
                    ZStack{
                        TextView(text: $newShopAddress)
                            .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height*0.2)
                            .border(Color.secondary, width: 1)
                        
                        
                        if newShopAddress == "" {
                            Text("Insert Shop Address here")
                                .foregroundColor(.secondary)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    
                    Text("Owner Valid ID")
                        .font(.system(size: 24, weight: .bold))
                    
                    VStack{
                        if newShopOwnerID == UIImage(systemName: "plus.circle"){
                            imagePlaceholder
                                .resizable()
                                .frame(width: 120, height: 120)
                                .foregroundColor(.secondary)
                                .onTapGesture {
                                    self.imagePickerState = .ownerValidID
                                    self.isShowingImagePicker = true
                            }
                        }
                        else{
                            Image(uiImage: newShopOwnerID)
                                .resizable()
                                .frame(width: 150, height: 120)
                                .foregroundColor(.secondary)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .onTapGesture {
                                    self.imagePickerState = .ownerValidID
                                    self.isShowingImagePicker = true
                            }
                        }
                        
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    
                    Text("Store Logo")
                        .font(.system(size: 24, weight: .bold))
                    
                    VStack{
                        if newShopLogo == UIImage(systemName: "plus.circle"){
                            imagePlaceholder
                                .resizable()
                                .frame(width: 120, height: 120)
                                .foregroundColor(.secondary)
                                .onTapGesture {
                                    self.imagePickerState = .storeLogo
                                    self.isShowingImagePicker = true
                            }
                        }
                        else{
                            Image(uiImage: newShopLogo)
                                .resizable()
                                .frame(width: 120, height: 120)
                                .foregroundColor(.secondary)
                                .clipShape(Circle())
                                .onTapGesture {
                                    self.imagePickerState = .storeLogo
                                    self.isShowingImagePicker = true
                            }
                        }
                        
                        Rectangle()
                            .frame(height: 20)
                            .foregroundColor(.clear)
                        
                        Button (action: {
                            self.saveNewShopDataToCloud()
                        }) {
                            Text("Open")
                                .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0))
                                .padding()
                                .frame(width: UIScreen.main.bounds.width * 0.9)
                            
                        }
                        .background(Color(red: 0.511, green: 0.298, blue: 0.001))
                        .cornerRadius(10)
                        .padding(.top, 15)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    
                }
                .padding(.horizontal, 25.0)
            }
            .onTapGesture {UIApplication.shared.endEditing()}
            .background(Image("Background"))
            .sheet(isPresented: $isShowingImagePicker, onDismiss: {
                self.isShowingImagePicker = false
            }, content: {
                if self.imagePickerState == .ownerValidID {
                    ImagePicker(image: self.$newShopOwnerID)
                }
                else if self.imagePickerState == .storeLogo {
                    ImagePicker(image: self.$newShopLogo)
                }
            })
        }
        

    }
    
    func saveNewShopDataToCloud(){
        //Insert data ke cloudkit
        
        //1.Buat dulu recordnya
        let newRecord = CKRecord(recordType: "Store")
        
        //Saving image
        //let data = UIImage(named: "Background1")!.pngData()
        let data = newShopOwnerID.pngData()// UIImage ->
        
        let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")
        
        do {
            //try data!.writeToURL(url, options: [])
            try data!.write(to: url!, options: [])
        } catch let e as NSError {
            print("Error! \(e)");
            return
        }
        let ownerValidIDPhoto = CKAsset(fileURL: url!)
        
        let dataLogo = newShopLogo.pngData()// UIImage ->
        
        let urlLogo = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")
        
        do {
            //try data!.writeToURL(url, options: [])
            try dataLogo!.write(to: urlLogo!, options: [])
        } catch let e as NSError {
            print("Error! \(e)");
            return
        }
        let shopLogo = CKAsset(fileURL: urlLogo!)
        
        //End image saving
        
        //Take current userLoggedOn ID to make reference
        let ownerReference = CKRecord.Reference(recordID: userLoggedOn.id, action: .deleteSelf)
        
        //2.Set property
        newRecord.setValue(newShopName, forKey: "name")
        newRecord.setValue(newShopAddress, forKey: "address")
        newRecord.setValue(ownerValidIDPhoto, forKey: "ownerValidID")
        newRecord.setValue(shopLogo, forKey: "logo")
        newRecord.setValue(ownerReference, forKey: "owner")

        
        //3.Execute save or insert
        let database = CKContainer.default().publicCloudDatabase
        database.save(newRecord) { record, error in
            if let err = error {
                print(err.localizedDescription)
            }
            
            print(record)
           
            
            self.UserStore.id = newRecord.recordID
            self.UserStore.name = self.newShopName
            self.UserStore.address = self.newShopAddress
            self.UserStore.owner = self.userLoggedOn.id
            self.UserStore.ownerValidID = self.newShopOwnerID
            self.UserStore.logo = self.newShopLogo
            
            DispatchQueue.main.async {
                //Update UI
            }
            
        }
    }
    


}

struct OpenNewShopView_Previews: PreviewProvider {
    static var previews: some View {
        OpenNewShopView()
    }
}
