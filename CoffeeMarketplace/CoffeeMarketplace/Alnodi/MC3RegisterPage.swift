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
    
    @State var newUser = userData()
    @State var photoPreview : Image?
    @State var isShowingImagePicker = false
    //@State var inputImage = Image("test")
    
    var body: some View {
        VStack{
            //Untuk pemisah antara nav title dengan konten dibawahnya
            Rectangle()
                .frame(width: 10, height: 10)
                .foregroundColor(Color.clear)
            
            ZStack{
                RegisterFormBackgroundView()
                RegisterFormText(newUser: $newUser)
            }
            
            RegisterButton(newUser: $newUser)
            
            if photoPreview != nil {
                photoPreview?
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
            }
            else {
                Text("Tap here to select a picture")
                    .foregroundColor(.black)
                    .padding()
                    .onTapGesture {
                        self.isShowingImagePicker = true
                }
            }
            
            Spacer()
        }
            //.background(Image("Background2"))
        .background(Image("Background"))
        .navigationBarTitle("Create an Account")
            .sheet(isPresented: $isShowingImagePicker,
                   onDismiss: loadImage) {
                    ImagePicker(image: self.$newUser.profilePhoto)
        }
    }
    
    func loadImage(){
        photoPreview = Image(uiImage: newUserData.profilePhoto!)
    }
}


struct userData {
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var phoneNumber: String = ""
    var profilePhoto = Image("test")
}

struct RegisterFormBackgroundView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 20, height: 500)
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
    @Binding var newUser: userData
    
    var body: some View {
        Button (action: {
            self.saveDataToCloudKit()
        }) {
            Text("Register")
                .padding()
                .frame(width: UIScreen.main.bounds.width - 60)
                .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0))
        }
        .background(Color(red: 0.511, green: 0.298, blue: 0.001))
        .cornerRadius(10)
        .padding(.top, 15)
    }
    
        func saveDataToCloudKit(){
            //Insert data ke cloudkit
    
            //1.Buat dulu recordnya
            let newRecord = CKRecord(recordType: "UserData")
            
            //Saving image
            //let data = UIImage(named: "Background1")!.pngData()
            let data = newUserData.profilePhoto?.pngData()// UIImage -> NSData, see also UIImageJPEGRepresentation
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
    
                DispatchQueue.main.async {
                    //Update UI
                }
    
            }
        }
}


struct MC3RegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        MC3RegisterPage()
    }
}



