//
//  DashboardView.swift
//  CoffeeMarketplace
//
//  Created by Laurens Bryan Cahyana on 17/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI

struct DashboardView: View {
    
    @State private var searchText : String = ""
    
    var trendingCoffee: [Coffeee] = [
        Coffeee(name: "Trending Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "Trending Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 110000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "Trending Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 150000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "Trending Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 125000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "Trending Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 375000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    ]
    
    var newCoffee: [Coffeee] = [
        Coffeee(name: "New Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 300000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "New Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 500000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "New Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 500000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "New Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 700000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "New Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 500000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    ]
    
    var greenBeansCoffee: [Coffeee] = [
        Coffeee(name: "Green Beans Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 200000, roastLevel: 0, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "Green Beans Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 300000, roastLevel: 0, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "Green Beans Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 400000, roastLevel: 0, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "Green Beans Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 0, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "Green Beans Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 800000, roastLevel: 0, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    ]
    
    var lightRoastCoffee: [Coffeee] = [
        Coffeee(name: "Light Roast Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "Light Roast Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 400000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "Light Roast Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "Light Roast Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 500000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "Light Roast Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 600000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    ]
    
    var mediumRoastCoffee: [Coffeee] = [
        Coffeee(name: "Medium Roast Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 400000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "Medium Roast Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "Medium Roast Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 700000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "Medium Roast Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "Medium Roast Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 500000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    ]
    
    var darkRoastCoffee: [Coffeee] = [
        Coffeee(name: "Dark Roast Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "Dark Roast Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 400000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "Dark Roast Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "Dark Roast Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 200000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        Coffeee(name: "Dark Roast Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 400000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    ]
    
    
    var body: some View {
        VStack {
            HStack{
                SearchBar(text: $searchText)
                    .frame(height: UIScreen.main.bounds.height * 0.05)
                    .padding(.leading, 5)
                Button(action: {

                }) {
                    Image("FilterIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.07)
                }.padding(.trailing, 5)
                Button(action: {

                }) {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.07)
                }.padding(.trailing, 15)
            }
            
            ScrollView(.vertical, showsIndicators: true){
                CoffeeHorizontalCollectionView(coffeeInCategory: trendingCoffee, category: "Trending")
                    .padding(5)
                CoffeeHorizontalCollectionView(coffeeInCategory: newCoffee, category: "New")
                    .padding(5)
                CoffeeHorizontalCollectionView(coffeeInCategory: greenBeansCoffee, category: "Green Beans")
                    .padding(5)
                CoffeeHorizontalCollectionView(coffeeInCategory: lightRoastCoffee, category: "Light Roast")
                    .padding(5)
                CoffeeHorizontalCollectionView(coffeeInCategory: mediumRoastCoffee, category: "Medium Roast")
                    .padding(5)
                CoffeeHorizontalCollectionView(coffeeInCategory: darkRoastCoffee, category: "Dark Roast")
                    .padding(5)
            }
            
//
            
        }
    }
}

struct CoffeeHorizontalCollectionView: View {
    var coffeeInCategory: [Coffeee]
    
    var category: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(category)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .padding(.leading ,10)
            ScrollView(.horizontal, showsIndicators: true){
                HStack{
                    ForEach(0 ..< 5){ index in
                        NavigationLink(destination: ProductDetail(selectedCoffee: self.coffeeInCategory[index])){
                            CoffeeIcon(coffeeToDisplay: self.coffeeInCategory[index])
                        }
//                        CoffeeIcon(coffeeToDisplay: self.coffeeInCategory[index])
                    }
                }.padding(.leading, 10)
            }
        }
    }
}


struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
