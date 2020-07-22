//
//  CoffeeIcon.swift
//  CoffeeMarketplace
//
//  Created by Laurens Bryan Cahyana on 16/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI


struct CoffeeIcon: View {
    
    var coffeeImage: String = "Coffee"
    var coffeeName: String = "Coffee Name"
    var coffeePrice: Int = 0
    
    var body: some View {
        ZStack(alignment: .bottomLeading){
            Image(coffeeImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(
                    width: UIScreen.main.bounds.width * 0.45,
                    height: UIScreen.main.bounds.height * 0.15,
                    alignment: .topLeading
                )
                .clipped()
            VStack(){
                Text(coffeeName)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .padding(.leading,5)
                    .font(.system(size: 20))
//                Spacer()
                Text("Rp.\(coffeePrice)")
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.trailing)
                    .padding(.trailing,5)
            }
                .frame(width: UIScreen.main.bounds.width * 0.45)
                .background(Color.black.opacity(0.7))
        }
            .cornerRadius(10)
            .frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.height * 0.15)
    }
}

struct CoffeeIcon_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeIcon()
    }
}
