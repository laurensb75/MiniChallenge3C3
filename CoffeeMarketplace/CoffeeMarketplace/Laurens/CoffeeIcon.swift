//
//  CoffeeIcon.swift
//  CoffeeMarketplace
//
//  Created by Laurens Bryan Cahyana on 16/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI

var screenSize = UIScreen.main


struct CoffeeIcon: View {
    var body: some View {
        ZStack(alignment: .bottomLeading){
            Image("Coffee")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(
                    width: screenSize.bounds.width * 0.45,
                    height: screenSize.bounds.height * 0.15,
                    alignment: .topLeading
                )
                .clipped()
            HStack(){
                Text("Coffee Name")
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.leading,5)
                Spacer()
                Text("Price")
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.trailing)
                    .padding(.trailing,5)
            }
            .background(Color.black.opacity(0.6))
        }
        .cornerRadius(10)
        .frame(width: screenSize.bounds.width * 0.45, height: screenSize.bounds.height * 0.15)
    }
}

struct CoffeeIcon_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeIcon()
    }
}
