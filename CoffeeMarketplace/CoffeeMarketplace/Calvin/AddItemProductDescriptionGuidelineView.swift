//
//  AddItem-ProductDescriptionGuideline-View.swift
//  myShop-test
//
//  Created by Calvin Dalenta on 24/07/20.
//  Copyright © 2020 Apple Academy. All rights reserved.
//

import SwiftUI

struct Guideline {
    var title: String
    var description: String
}

var guidelines: [Guideline] = [
    Guideline(title: "The Taste", description: "Tell Buyers what your Coffee taste like, what kind of unique and special taste that your coffee offer."),
    Guideline(title: "The Aroma", description: "Tell Buyers what your Coffee smells like, what kind of aroma that make the buyer can't forget about your coffee"),
    Guideline(title: "The Brew Type", description: "Which kind of brew that you coffee bean best for."),
    Guideline(title: "The Quality", description: "Tell Buyers what kind of Coffee bean that you sell, tell them the differences that your Coffee have compared to other Coffee that make Buyer make your coffee their no 1."),
    Guideline(title: "The Farm/Source", description: "Tell the Buyer where do your Coffee comes from like which country etc. If it can be as detailed as which farm it is from, it will be extra story to interest your Buyers."),
    Guideline(title: "The Roaster", description: "Some Buyers really appreciate if you can tell who is the Roaster and some Roaster can use some of the fame they can get from roasting your coffee."),
    Guideline(title: "The Farmer", description: "Coffee Farmer have little recognition and every coffee farm have a different taste")
]

struct AddItem_ProductDescriptionGuideline_View: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .leading, spacing: 0){
                    ForEach(guidelines.indices){ index in
                        VStack(alignment: .leading){
                            Text(guidelines[index].title)
                                .font(.headline)
                                .padding(.horizontal, UIScreen.main.bounds.width*0.05)
                            Text(guidelines[index].description)
                                .padding(.horizontal, UIScreen.main.bounds.width*0.05)
                                .font(.body)
                            
                        }.padding(.vertical, 10)
                    }
            }
                .background(SellerConstant.lightBrown)
                .cornerRadius(15)
                .addBorder(Color.black, cornerRadius: 15)
                .padding()
                .background(SellerConstant.mainBackground.scaledToFit())
                .navigationBarTitle("Description Guideline")
        }
    }
}

struct AddItem_ProductDescriptionGuideline_View_Previews: PreviewProvider {
    static var previews: some View {
        AddItem_ProductDescriptionGuideline_View()
    }
}
