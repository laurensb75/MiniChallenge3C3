//
//  SearchFilterView.swift
//  CoffeeMarketplace
//
//  Created by Laurens Bryan Cahyana on 29/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI

struct SearchFilterView: View {
    @State private var searchTextField : String = ""
    
    let searchResult: [Coffeee] = [
        .init(id: "1", name: "Trending Coffee 1", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 100000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "2", name: "Trending Coffee 2", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 110000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "3", name: "Trending Coffee 3", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 150000, roastLevel: 3, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "4", name: "Trending Coffee 4", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 125000, roastLevel: 2, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
        .init(id: "5", name: "Trending Coffee 5", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 375000, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee"),
    ]
    
    
    var body: some View {
        VStack{
            //search bar
            HStack{
                SearchBar(text: $searchTextField)
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
                    .padding(.trailing, 5)
            }
            
            //content
            
            ScrollView(.vertical){
//                ForEach(searchResult){ items in
//                    HStack{
//                        ForEach(0 ..< 2){ item in
//                            CoffeeIcon(coffeeToDisplay: items)
//                        }
//                    }
//                }
                ForEach(0 ..< searchResult.count/2){ items in
                    HStack{
                        ForEach(0 ..< 2){ item in
                            CoffeeIcon(coffeeToDisplay: self.searchResult[ (items * 2) + item ])
                        }
                    }
                }
                
            }
        }.background(Image("Background").resizable().edgesIgnoringSafeArea(.all).scaledToFill().edgesIgnoringSafeArea(.all)).onTapGesture {UIApplication.shared.endEditing()}
        
    }
}

struct SearchFilterView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilterView()
    }
}
