//
//  Coffee.swift
//  CoffeeMarketplace
//
//  Created by Laurens Bryan Cahyana on 24/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

struct Coffeee: Identifiable {
    var id: String
    var name: String
    var description: String
    var price: Int
    var roastLevel: Int
    var flavour: [Bool]
    var image: String
}

struct Review {
    var sender: String
    var rating: Int
    var description: String
    
}
