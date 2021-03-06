//
//  MC3RegisterPage.swift
//  MC3LoginRegisterUsingSwiftUI
//
//  Created by Alnodi Adnan on 19/07/20.
//  Copyright © 2020 Alnodi Adnan. All rights reserved.
//

import SwiftUI
import CloudKit

//var newUser : userData?

struct MC3RegisterPage: View {
    @Environment(\.presentationMode) var presentation
    
    @State var newUser = userData()
    @State var photoPreview : UIImage = UIImage(systemName: "person.fill")!
    @State var isShowingImagePicker = false
    //@State var inputImage = Image("test")
    
    var body: some View {
        ScrollView{
            VStack{
                if photoPreview == UIImage(systemName: "person.fill"){
                    Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .scaledToFit()
                    .clipShape(Circle())
                    .padding(.top, 20)
                    
                }
                else{
                    Image(uiImage: photoPreview)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .scaledToFit()
                    .clipShape(Circle())
                    .padding(.top, 20)
                }
                

                
                Text("Tap here to select a picture")
                    .foregroundColor(.blue)
                    .padding()
                    .onTapGesture {
                        self.isShowingImagePicker = true
                    }
                
                ZStack{
                    RegisterFormBackgroundView()
                    RegisterFormText(newUser: $newUser)
                }
                
                
                
                RegisterButton(newUser: $newUser)
                Spacer()
            }
                //.background(Image("Background2"))
                .background(Image("Background"))
                .navigationBarTitle("Create an Account", displayMode: .inline)
                .sheet(isPresented: $isShowingImagePicker,
                       onDismiss: loadImage) {
                            ImagePicker(image: self.$photoPreview)
                        }
                //.navigationBarTitle("")
                //.navigationBarHidden(true)
    }.onTapGesture {UIApplication.shared.endEditing()}
}
        
    
    func loadImage(){
        photoPreview = newData.profilePhoto!
        newUser.profilePhoto = newData.profilePhoto!
    }
}


//struct userData {
//    var name: String = ""
//    var email: String = ""
//    var password: String = ""
//    var phoneNumber: String = ""
//    var profilePhoto = Image("test")
//}

//struct newData {
//    static var profilePhoto = UIImage(named: "test")
//}

struct RegisterFormBackgroundView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width * 0.95, height: 500)
            .cornerRadius(20)
    }
}


struct RegisterFormText: View {
    @Binding var newUser: userData
    var lineColor = Color(red: 0.843, green: 0.843, blue: 0.852)
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Name")
                .font(.system(size: 24, weight: .bold))
            VStack{
                TextField("Name", text: $newUser.name)
                HorizontalLine(color: lineColor)
            }
            .padding()
            
            Text("Email")
                .font(.system(size: 24, weight: .bold))
            VStack{
                TextField("Email@email.com", text: $newUser.email)
                HorizontalLine(color: lineColor)
            }
            .padding()
            
            Text("Password")
                .font(.system(size: 24, weight: .bold))
            VStack{
                SecureField("Password", text: $newUser.password)
                HorizontalLine(color: lineColor)
            }
            .padding()
            
            Text("Phone Number")
                .font(.system(size: 24, weight: .bold))
            VStack{
                TextField("Phone Number", text: $newUser.phoneNumber)
                    .keyboardType(UIKeyboardType.decimalPad)
                HorizontalLine(color: lineColor)
            }
            .padding()
        }
        .padding(.horizontal, 25.0)
    }
}

struct RegisterButton: View {
    @Environment(\.presentationMode) var presentation
    @Binding var newUser: userData
    @State var showingAlert = false
    @State var message = ""
    
    var body: some View {
        Button (action: {
            if self.validateRegisterData() {
                self.saveDataToCloudKit()
                
                //self.presentation.wrappedValue.dismiss()
            }
            else{
                self.message = "Register failed, all field must be filled!"
                self.showingAlert = true
            }
            
        }) {
            Text("Register")
                .padding()
                .frame(width: UIScreen.main.bounds.width - 60)
                .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0))
        }
        .background(Color(red: 0.511, green: 0.298, blue: 0.001))
        .cornerRadius(10)
        .padding(.top, 15)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Alert"), message: Text(message), dismissButton: .default(Text("OK")) {
                if self.message == "Register Success" {
                    self.presentation.wrappedValue.dismiss()
                }
                    
                })
        }
    }
    
    func saveDataToCloudKit(){
        //Insert data ke cloudkit
        
        //1.Buat dulu recordnya
        let newRecord = CKRecord(recordType: "UserData")
        
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
        let profilePhoto = CKAsset(fileURL: url!)
        
        //2.Set property
        newRecord.setValue(newUser.name, forKey: "name")
        newRecord.setValue(newUser.email, forKey: "email")
        newRecord.setValue(newUser.password, forKey: "password")
        newRecord.setValue(newUser.phoneNumber, forKey: "phoneNumber")
        newRecord.setValue(profilePhoto, forKey: "profilePhoto")
        
        //3.Execute save or insert
        let database = CKContainer.default().publicCloudDatabase
        database.save(newRecord) { record, error in
            if let err = error {
                print(err.localizedDescription)
            }
            
            print(record)
            
            if let record = record {
                self.message = "Register Success"
                self.showingAlert = true
            }
            else {
                self.message = "Register Failed"
                self.showingAlert = true
            }
            
            DispatchQueue.main.async {
                //Update UI
            }
            
        }
    }
    
    func validateRegisterData() -> Bool{
        if newUser.name == ""{
            return false
        }
        
        else if newUser.email == "" {
            return false
        }
        
        else if newUser.password == "" {
            return false
        }
        
        else if newUser.phoneNumber == "" {
            return false
        }
        
        else if newUser.profilePhoto == UIImage(systemName: "person.fill") {
            return false
        }
        
        
        return true
    }
}


struct MC3RegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        MC3RegisterPage()
    }
}



