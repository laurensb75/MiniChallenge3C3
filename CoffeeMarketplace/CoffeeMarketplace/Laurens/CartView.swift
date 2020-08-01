//
//  CartView.swift
//  testSwiftUI
//
//  Created by Laurens Bryan Cahyana on 30/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI

struct CartView: View {
    let itemInCart: [Coffeee] = [
        .init(id: "1", name: "Trending Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "2", name: "Trending Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 110000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "3", name: "Trending Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 150000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "4", name: "Trending Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 125000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Trending Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 375000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
    ]
    
    
    var body: some View {
        NavigationView{
            VStack{
                List(itemInCart) { item in
                    CartItemIcon(coffeeItem: item, ammount: 1).border(Color.black, width: 1).cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                }
                
                Button(action: {
                    
                }) {
                    Text("Checkout")
                        .foregroundColor(Color.black)
                }
                    .frame(width: UIScreen.main.bounds.width * 0.6, height: 45)
                    .background(Color.init(.brown))
                    .cornerRadius(10.0)
            }
            .navigationBarTitle("Cart", displayMode: .automatic)
        }
    }
}


struct CartItemIcon: View {
    var coffeeItem: Coffeee = .init(id: "0", name: "Coffee Name", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 0, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    @State var ammount: Int = 1
    @State var grindState = 0
    
    
    var body: some View {
        HStack{
            Image("Coffee")
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.4)
                .cornerRadius(10)
                .padding(.leading)
            VStack {
                VStack(alignment: .leading){
                    Text(coffeeItem.name)
                        .font(.headline)
                    Text("Rp.\(coffeeItem.price),-")
                    HStack{
                        Text("Qty")
                        HStack{
                            TextField("0", value: $ammount, formatter: NumberFormatter()).padding(.leading, 10.0).keyboardType(UIKeyboardType.decimalPad)
                            VStack{
                                Button(action: {
                                    self.ammount += 1
                                }) {
                                    Image(systemName: "chevron.up")
                                }
                                .padding(.trailing, 5.0)
                                Button(action: {
                                    self.ammount -= (self.ammount<=1 ? 0 : 1)
                                }) {
                                    Image(systemName: "chevron.down")
                                }
                                .padding(.trailing, 5.0)
                            }
                        }.frame(width: 60, height: 40).border(Color.black, width: 1)
                        Spacer()
                        Button(action: {
                            print("asdfasdf")
                        }) {
                            Image(systemName: "trash").resizable().frame(width: UIScreen.main.bounds.width * 0.075, height: UIScreen.main.bounds.width * 0.075).aspectRatio(contentMode: .fit)
                        }
                    }
                }
                Picker(selection: $grindState, label: Text("Grind State")) {
                    Text("Beans").tag(1)
                    Text("Grinded").tag(2)
                    }.frame(width: 100.0, height: 50).clipped()
            }
            
            Spacer()
            }.cornerRadius(15).frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
    }
}


struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
