//
//  MyShopView.swift
//  myShop-test
//
//  Created by Calvin Dalenta on 21/07/20.
//  Copyright © 2020 Apple Academy. All rights reserved.
//

import SwiftUI

struct CoffeeData{
    var name: String
    var price: String
    var coffeeImage: Image
}

let testData: [CoffeeData] = [
    CoffeeData(name: "Coffee 1", price: "1", coffeeImage: Image("Coffee")),
    CoffeeData(name: "Coffee 2", price: "2", coffeeImage: Image("Coffee")),
    CoffeeData(name: "Coffee 3", price: "3", coffeeImage: Image("Coffee")),
    CoffeeData(name: "Coffee 4", price: "4", coffeeImage: Image("Coffee")),
    CoffeeData(name: "Coffee 5", price: "5", coffeeImage: Image("Coffee")),
    CoffeeData(name: "Coffee 6", price: "6", coffeeImage: Image("Coffee")),
    CoffeeData(name: "Coffee 7", price: "7", coffeeImage: Image("Coffee")),
    CoffeeData(name: "Coffee 8", price: "8", coffeeImage: Image("Coffee")),
    CoffeeData(name: "Coffee 9", price: "9", coffeeImage: Image("Coffee")),
    CoffeeData(name: "Coffee 10", price: "10", coffeeImage: Image("Coffee")),
    CoffeeData(name: "Coffee 11", price: "11", coffeeImage: Image("Coffee"))
]

struct MyShopView: View {
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                if testData.isEmpty{
                    Text("Add New Product").padding(50)
                } else {
                    MyShopItemList(coffeeList: testData)
                }
            }.navigationBarTitle("Shop", displayMode: .inline).navigationBarItems(trailing: Button(action: {}, label: {NavigationLink(destination: AddItemView()) {
                Image(systemName: "plus").foregroundColor(SellerConstant.darkBrown).font(Font.custom("", size: 24))
                }}))
        }
    }
}

struct MyShopItemList: View{
    
    var processedCoffeeList: [[CoffeeData]] = []
    
    init(coffeeList: [CoffeeData]) {
        processedCoffeeList = coffeeList.chunked(into: coffeeList.count/(coffeeList.count/2))
    }
    
    var body: some View{
        VStack(alignment: .leading){
            ForEach(processedCoffeeList.indices){i in
                HStack{
                    ForEach(0..<self.processedCoffeeList[i].count, id: \.self){j in
                        MyShopItem(name: self.processedCoffeeList[i][j].name, coffeePrice: "Rp\(self.processedCoffeeList[i][j].price),-", coffeeImage: self.processedCoffeeList[i][j].coffeeImage).padding(5)
                    }
                }
            }
        }
    }
    
}

struct MyShopItem: View{
    
    var name: String
    var coffeePrice: String
    var coffeeImage: Image
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            ZStack{
                RoundedRectangle(cornerRadius: 15).foregroundColor(SellerConstant.lightBrown).addBorder(Color.black, width: 1, cornerRadius: 15).frame(width: 175, height: 250)
                
                VStack(alignment: .leading, spacing: 0) {

                    Rectangle().foregroundColor(Color.gray).overlay(
                    coffeeImage
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: nil, idealWidth: nil, maxWidth: UIScreen.main.bounds.width, minHeight: nil, idealHeight: nil, maxHeight: 300, alignment: .center)
                    .clipped())
                    

                    VStack(alignment: .leading) {
                        Text(name)
                        Text(coffeePrice)
                    }
                    .padding(12)

                }
                .background(Color.white)
                .cornerRadius(15)
                .addBorder(Color.black, width: 0.5, cornerRadius: 15)
                .frame(width: 150, height: 200)
                
            }
        }
    }
}

struct MyShopView_Previews: PreviewProvider {
    static var previews: some View {
        MyShopView()
    }
}

extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        return overlay(RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(content, lineWidth: width))
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
