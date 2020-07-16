//
//  CoffeeHorizontalCollectionView.swift
//  CoffeeMarketplace
//
//  Created by Laurens Bryan Cahyana on 16/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI


struct CoffeeHorizontalCollectionView: View {
    var category: String = "Category"
    
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
                        CoffeeIcon(coffeeImage: "Coffee", coffeeName: "Bewitched", coffeePrice: 250000)
                    }
                }.padding(.leading, 10)
            }
        }
    }
}

struct CoffeeHorizontalCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeHorizontalCollectionView()
    }
}
