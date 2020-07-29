//
//  History.swift
//  CoffeeMarketplace
//
//  Created by Gilbert Gozalie on 7/24/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI
struct Transactions: Hashable{
    var id = UUID()
    var date :String
    var time: String
    var coffee: String
    var qty: Int
    var total: Int
}
var lineColor = Color(red: 0.843, green: 0.843, blue: 0.852)
let transactions = [Transactions(date: "12 Juni 2020", time: "12:30 PM", coffee: "Coffee A", qty: 10, total: 10000), Transactions(date: "12 Juni 2020", time: "12:30 PM", coffee: "Coffee A", qty: 10, total: 10000)]
struct History: View {
    var body: some View {
            NavigationView {
                
                ScrollView(.vertical){
                   
                        //Untuk pemisah antara nav title dengan konten dibawahnya
                                       Rectangle()
                                           .frame(width: 10, height: 80)
                                           .foregroundColor(Color.clear)
                            
                                //taro looping disini
                                ForEach(0..<transactions.count){ index in
                                    
                                    VStack(alignment: .leading){
                                    
                                        Text(transactions[index].date)
                                            .padding(.leading, 15.0)
                                            .padding(.top, 5)
                                        HorizontalLine(color: lineColor)
                                        Text(transactions[index].time) .padding(.leading, 15.0)
                                        Text(transactions[index].coffee) .padding(.leading, 15.0)
                                        Text("\(transactions[index].qty), Total: \(transactions[index].total)") .padding(.leading, 15.0)
                                        Button(action: {
                                            // your action here
                                        }) {
                                            Text("Review")
                                                .frame(alignment: .center)
                                                .foregroundColor(Color.white)
                                                .frame(minWidth: 0, maxWidth: 100)
                                                .padding(3)
                                                .background(Color.init(.brown))
                                            .cornerRadius(15)
                                            .padding(.leading,135)
                                                .padding(.bottom,10)

                                        }
                                        }
                                        //background history
                                        .background(Color.white)
                                        .frame(width: UIScreen.main.bounds.width * 0.9)
                                        .cornerRadius(10)
                                    .padding(10)
                                }
      
                    
                }.navigationBarTitle("History Transaction", displayMode: .inline)
                    .background(
                        Image("Background2")
                        .scaledToFill())
                    .edgesIgnoringSafeArea(.all)
                
                    
        }
    }
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History()
    }
}

struct HorizontalLineShape: Shape {

    func path(in rect: CGRect) -> Path {

        let fill = CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height)
        var path = Path()
        path.addRoundedRect(in: fill, cornerSize: CGSize(width: 2, height: 2))

        return path
    }
}

struct HorizontalLine: View {
    private var color: Color? = nil
    private var height: CGFloat = 1.0

    init(color: Color, height: CGFloat = 1.0) {
        self.color = color
        self.height = height
    }

    var body: some View {
        HorizontalLineShape().fill(self.color!).frame(minWidth: 0, maxWidth: .infinity, minHeight: height, maxHeight: height)
    }
}
