//
//  AddItem-BeanType-View.swift
//  myShop-test
//
//  Created by Calvin Dalenta on 22/07/20.
//  Copyright © 2020 Apple Academy. All rights reserved.
//

import SwiftUI

struct AddItem_BeanType_View: View {
    
    @Environment(\.presentationMode) var presentation
    @Environment (\.defaultMinListRowHeight) var rowHeight
    
    @State var beanType: [String] = [
        "Green",
        "Roasted"
    ]
    @Binding var selections: String
    
    var body: some View{
            VStack{
                RoundedRectangle(cornerRadius: 15).frame(width: UIScreen.main.bounds.width*0.9, height: rowHeight * 2).foregroundColor(.white).overlay(
                List {
                    ForEach(self.beanType, id: \.self) { item in
                        SelectionRow(title: item, isSelected: self.selections.contains(item)) {
                            if self.selections.contains(item) {
                                self.selections = ""
                            }
                            else {
                                self.selections = item
                            }
                            self.presentation.wrappedValue.dismiss()
                        }
                    }
                }.colorMultiply(SellerConstant.lightBrown)
                    ).cornerRadius(15)
                .addBorder(Color.black, cornerRadius: 15).padding()
                Spacer()
            }.background(SellerConstant.mainBackground).navigationBarTitle("Bean Type", displayMode: .inline)
    }
}

//struct AddItem_BeanType_View_Previews: PreviewProvider {
//    static var previews: some View {
//        AddItem_BeanType_View()
//    }
//}
