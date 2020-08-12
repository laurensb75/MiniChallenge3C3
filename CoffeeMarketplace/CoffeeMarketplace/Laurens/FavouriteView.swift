//
//  Favourite.swift
//  testSwiftUI
//
//  Created by Laurens Bryan Cahyana on 03/08/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI

struct FavouriteView: View {
    var favouritedCoffee: [Coffeee] = [
        .init(id: "5", name: "Dark Roast Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Dark Roast Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 400000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Dark Roast Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Dark Roast Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 200000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Dark Roast Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 400000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    ]
    
    var body: some View {
        VStack{
            ScrollView{
                ForEach(0 ..< favouritedCoffee.count/2+1, id: \.self){ collect in
                    HStack{
                        ForEach(0 ..< 2, id: \.self){ collection in
                            CoffeeIcon(coffeeToDisplay: (collect * 2 + collection < self.favouritedCoffee.count) ? (self.favouritedCoffee[collect * 2 + collection]) : (self.favouritedCoffee[collect * 2 + collection - self.favouritedCoffee.count]))
                        }
                    }
                }
            }
        }.background(Image("Background"))
    }

}


struct Favourite_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
