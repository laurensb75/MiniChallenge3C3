//
//  AddItem-ProductDescription-View.swift
//  myShop-test
//
//  Created by Calvin Dalenta on 22/07/20.
//  Copyright © 2020 Apple Academy. All rights reserved.
//

import SwiftUI

struct AddItem_ProductDescription_View: View {
    
    @Binding var descriptionTextField: String
    
    var body: some View {
        
        //TODO: Multiline TextField
        VStack{
//            RoundedRectangle(cornerRadius: 15).frame(width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.height*0.25).foregroundColor(SellerConstant.lightBrown).addBorder(Color.black, cornerRadius: 15).padding()
//                .overlay(
//                    TextField("Tap right left for Coffee Description Guideline", text: $descriptionTextField).padding().frame(width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.height*0.25).border(Color.black)
//                )
            
            ZStack{
                TextView(
                    text: $descriptionTextField
                )
                    .frame(width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.height*0.25).cornerRadius(15).addBorder(Color.black, cornerRadius: 15).offset(x: 0, y: 50)
                
                if descriptionTextField.isEmpty{
                    Text("Tap left right for Coffee Description Guideline").foregroundColor(.secondary).offset(x: 0, y: (UIScreen.main.bounds.height*0.25)/5)
                }
            }

            Spacer()

        }.background(SellerConstant.mainBackground).navigationBarTitle("Product Description").navigationBarItems(trailing: Button(action: {}, label: {
            NavigationLink(destination: AddItem_ProductDescriptionGuideline_View()) {
            Image(systemName: "info.circle").foregroundColor(SellerConstant.darkBrown).font(Font.custom("", size: 24))
            }}))
    }
}

//struct AddItem_ProductDescription_View_Previews: PreviewProvider {
//    static var previews: some View {
//        AddItem_ProductDescription_View()
//    }
//}
