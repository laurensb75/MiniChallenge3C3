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
    var body: some View {
        ZStack(alignment: .top){
            NavigationView{
                ScrollView(.vertical, showsIndicators: true){
                    CoffeeHorizontalCollectionView(category: "Trending")
                        .padding(5)
                    CoffeeHorizontalCollectionView(category: "New")
                        .padding(5)
                    CoffeeHorizontalCollectionView(category: "Green Beans")
                        .padding(5)
                    CoffeeHorizontalCollectionView(category: "Light Roast")
                        .padding(5)
                    CoffeeHorizontalCollectionView(category: "Medium Roast")
                        .padding(5)
                    CoffeeHorizontalCollectionView(category: "Dark Roast")
                        .padding(5)
                }
            }
            SearchBar(text: $searchText).padding()
            
        }
    }
}



struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
