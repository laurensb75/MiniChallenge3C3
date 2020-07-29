//
//  AddItem-RoastType-View.swift
//  myShop-test
//
//  Created by Calvin Dalenta on 22/07/20.
//  Copyright © 2020 Apple Academy. All rights reserved.
//

import SwiftUI

struct AddItem_RoastType_View: View {
    
     @Environment(\.presentationMode) var presentation
    
     @State var beanType: [String] = [
           "Light",
           "Medium",
           "Dark",
           "Very Dark"
       ]
       @Binding var selections: String
       
       var body: some View{
           VStack{
               RoundedRectangle(cornerRadius: 15).frame(width: UIScreen.main.bounds.width*0.9, height: UIScreen.main.bounds.height*0.2).foregroundColor(.white).overlay(
               List {
                ForEach(0..<self.beanType.count, id: \.self) { index in
                    SelectionRow(title: self.beanType[index], isSelected: self.beanType[index] == self.selections) {
                           if self.beanType[index] == self.selections {
                                self.selections = ""
                           }
                           else {
                               self.selections = self.beanType[index]
                           }
                        self.presentation.wrappedValue.dismiss()
                       }
                   }
               }.colorMultiply(SellerConstant.lightBrown)
               ).cornerRadius(15)
               .addBorder(Color.black, cornerRadius: 15).padding()
               Spacer()
           }.background(SellerConstant.mainBackground).navigationBarTitle("Roast Type")
       }
}

//struct AddItem_RoastType_View_Previews: PreviewProvider {
//    static var previews: some View {
//        AddItem_RoastType_View()
//    }
//}
