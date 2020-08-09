//
//  AddItem-Flavour-View.swift
//  myShop-test
//
//  Created by Calvin Dalenta on 22/07/20.
//  Copyright © 2020 Apple Academy. All rights reserved.
//

import SwiftUI

struct AddItem_Flavour_View: View {
    
    @State var flavourType: [String] = ["Fruity", "Spices", "Green/Vegetative", "Nutty/Cocoa", "Chemical/Industrial", "Sweet", "Floral", "Sour/Fermented", "Papery/Musty", "Roasted"]
    
//    @State var flavourType: [String] = ["Roasted", "Spices", "Nutty/Cocoa", "Sweet", "Floral", "Fruity", "Sour/Fermented", "Green/Vegetative", "Papery/Musty", "Chemical/Industrial"]
    @Binding var selections: [String]
    
    @Environment (\.defaultMinListRowHeight) var rowHeight
    
    var body: some View{
        VStack{
            RoundedRectangle(cornerRadius: 15).frame(width: UIScreen.main.bounds.width*0.9, height: rowHeight * 10).foregroundColor(.white).overlay(
            List {
                ForEach(self.flavourType, id: \.self) { item in
                    SelectionRow(title: item, isSelected: self.selections.contains(item)) {
                        if self.selections.contains(item) {
                            self.selections.removeAll(where: { $0 == item })
                        }
                        else {
                            self.selections.append(item)
                        }
                    }
                }
            }.colorMultiply(SellerConstant.lightBrown)
            ).cornerRadius(15)
            .addBorder(Color.black, cornerRadius: 15).padding()
            Spacer()
        }.background(SellerConstant.mainBackground).navigationBarTitle("Flavour")
        
    }
}



//struct AddItem_Flavour_View_Previews: PreviewProvider {
//    static var previews: some View {
//        AddItem_Flavour_View()
//    }
//}
