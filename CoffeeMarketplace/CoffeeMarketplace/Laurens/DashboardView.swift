//
//  DashboardView.swift
//  CoffeeMarketplace
//
//  Created by Laurens Bryan Cahyana on 17/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true){
            CoffeeHorizontalCollectionView()
            CoffeeHorizontalCollectionView()
            CoffeeHorizontalCollectionView()
            CoffeeHorizontalCollectionView()
            CoffeeHorizontalCollectionView()
            CoffeeHorizontalCollectionView()
            CoffeeHorizontalCollectionView()
            CoffeeHorizontalCollectionView()
            CoffeeHorizontalCollectionView()
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
