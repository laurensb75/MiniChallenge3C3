//
//  CoffeeIcon.swift
//  CoffeeMarketplace
//
//  Created by Laurens Bryan Cahyana on 16/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI


struct CoffeeIcon: View {
    var coffeeToDisplay: Coffeee = Coffeee(name: "Coffee Name", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 0, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    
    var body: some View {
        ZStack(alignment: .bottomLeading){
            Image(coffeeToDisplay.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(
                    width: UIScreen.main.bounds.width * 0.45,
                    height: UIScreen.main.bounds.height * 0.15,
                    alignment: .topLeading
                )
                .clipped()
            VStack(){
                Text(coffeeToDisplay.name)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.leading,5)
                    .font(.system(size: 20))
//                Spacer()
                Text("Rp.\(coffeeToDisplay.price)")
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
