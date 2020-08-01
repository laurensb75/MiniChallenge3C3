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
        .init(id: "1", name: "Trending Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "2", name: "Trending Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 110000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "3", name: "Trending Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 150000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "4", name: "Trending Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 125000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Trending Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 375000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    ]
    
    var newCoffee: [Coffeee] = [
        .init(id: "6", name: "New Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 300000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "7", name: "New Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 500000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "8", name: "New Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 500000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "9", name: "New Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 700000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "10", name: "New Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 500000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    ]
    
    var greenBeansCoffee: [Coffeee] = [
        .init(id: "5", name: "Green Beans Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 200000, roastLevel: 0, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Green Beans Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 300000, roastLevel: 0, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Green Beans Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 400000, roastLevel: 0, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Green Beans Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 0, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Green Beans Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 800000, roastLevel: 0, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    ]
    
    var lightRoastCoffee: [Coffeee] = [
        .init(id: "5", name: "Light Roast Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Light Roast Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 400000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Light Roast Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Light Roast Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 500000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Light Roast Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 600000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    ]
    
    var mediumRoastCoffee: [Coffeee] = [
        .init(id: "5", name: "Medium Roast Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 400000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Medium Roast Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Medium Roast Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 700000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Medium Roast Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Medium Roast Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 500000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    ]
    
    var darkRoastCoffee: [Coffeee] = [
        .init(id: "5", name: "Dark Roast Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Dark Roast Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 400000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Dark Roast Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Dark Roast Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 200000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Dark Roast Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 400000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    ]
    
    
    var body: some View {
        NavigationView{
            VStack{
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
                    }
                        .foregroundColor(Color.black)
                        .padding(.trailing, 15.0)
                }
                //display item in category
                ScrollView(.vertical, showsIndicators: true){
                    CoffeeHorizontalCollectionView(coffeeInCategory: trendingCoffee, category: "Trending")
                        .padding([.leading, .bottom, .trailing], 5)
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
            }.background(Image("Background").resizable().edgesIgnoringSafeArea(.all).scaledToFill().edgesIgnoringSafeArea(.all))
        }
            .onTapGesture {UIApplication.shared.endEditing()}
            .navigationBarTitle("asdfasdf", displayMode: .automatic)
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
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(0 ..< 5){ index in
                        NavigationLink(destination: ProductDetail(selectedCoffee: self.coffeeInCategory[index])){
                            CoffeeIcon(coffeeToDisplay: self.coffeeInCategory[index]).opacity(1)
                        }
                            .buttonStyle(PlainButtonStyle())
                    }
                }.padding(.leading, 10)
            }.frame(height: 100)
        }
    }
}


struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
