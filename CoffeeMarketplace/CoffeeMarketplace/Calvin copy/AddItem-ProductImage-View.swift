//
//  AddItem-ProductImage-View.swift
//  myShop-test
//
//  Created by Calvin Dalenta on 22/07/20.
//  Copyright © 2020 Apple Academy. All rights reserved.
//

import SwiftUI

struct AddItem_ProductImage_View: View {
    
    @Binding var currentImage: Image
    @State var ea: Bool = false
    
    var body: some View {
        
        VStack{
            RoundedRectangle(cornerRadius: 15).frame(width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.height*0.25).foregroundColor(SellerConstant.lightBrown).addBorder(Color.black, cornerRadius: 15).padding()
                .overlay(
                    currentImage.resizable().frame(width: UIScreen.main.bounds.width*0.85, height: UIScreen.main.bounds.height*0.225).scaledToFit().cornerRadius(15)
            ).background(Text("No Image"))
            Spacer()
            
        }.background(SellerConstant.mainBackground).onTapGesture {
            self.ea = !self.ea
        }.sheet(isPresented: $ea){
            ImagePicker(image: self.$currentImage)
        }.navigationBarTitle("Product Image")
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var image: Image
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        @Binding var presentationMode: PresentationMode
        @Binding var image: Image
        
        init(presentationMode: Binding<PresentationMode>, image: Binding<Image>) {
            _presentationMode = presentationMode
            _image = image
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            image = Image(uiImage: uiImage)
            newData.profilePhoto = uiImage
            presentationMode.dismiss()
            
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, image: $image)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
}


//struct AddItem_ProductImage_View_Previews: PreviewProvider {
//
//    static var previews: some View {
//        AddItem_ProductImage_View()
//    }
//}
