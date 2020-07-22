//
//  ProductDetail.swift
//  CoffeeMarketplace
//
//  Created by Laurens Bryan Cahyana on 22/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI

struct ProductDetail: View {
    var coffeeName: String = "Coffee Name"
    var coffeeDescription: String = "Coffee Description"
    var coffeePrice: Int = 0
    var coffeeFlavours: [String] = ["Roasted", "Spices", "Nutty/Cocoa", "Sweet", "Floral", "Fruity", "Sour/Fermented", "Green/Vegetative", "Papery/Musty", "Chemical"]
    
    
    
    var body: some View {
        ZStack(alignment: .top){
            NavigationView {
                ScrollView(.vertical, showsIndicators: true){
                    //Coffee image
                    Image("Coffee")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: UIScreen.main.bounds.width * 1,
                            height: UIScreen.main.bounds.height * 0.3,
                            alignment: .topLeading
                        )
                        .clipped()
                    
                    
                    //Coffee title and price
                    VStack(alignment: .leading) {
                        Text(coffeeName)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding([.top, .leading], 15.0)
                        Text("Rp.\(coffeePrice)")
                            .font(.body)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding([.leading, .bottom], 15.0)
                    }
                        .frame(
                            width: UIScreen.main.bounds.width * 0.9,
                            alignment: .topLeading
                        )
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    
                    //Flavour
                    
                    
                    
                    //Coffee Description
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                            .padding([.top, .leading], 15.0)
                            .padding(.bottom,5)
                        Text("akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .padding([.leading, .bottom], 15.0)
                    }
                        .frame(
                            width: UIScreen.main.bounds.width * 0.9,
                            alignment: .topLeading
                        )
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    
                }
                    .background(
                        Image("Background")
                            .resizable()
                            .edgesIgnoringSafeArea(.all)
                            .scaledToFill()
                    )
                    .navigationBarTitle("",displayMode: .inline)
                    .navigationBarItems(
                        leading: Text("<Back"),
                        trailing: Text("Done")
                    )
            }
            Text("Product Detail")
                .font(.headline)
                .padding(.top)
        }
    }
}



struct ProductDetail_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetail()
    }
}
