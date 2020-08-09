//
//  ContentView.swift
//  CoffeeMarketplace
//
//  Created by Laurens Bryan Cahyana on 16/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView{
            DashboardView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Market")
                }

            CartView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }

            ProfileTest()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        //OpenNewShopView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
