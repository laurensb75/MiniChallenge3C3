//
//  ProductDetail.swift
//  CoffeeMarketplace
//
//  Created by Laurens Bryan Cahyana on 22/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI

struct ProductDetail: View {
    
    var selectedCoffee: Coffeee = .init(id: "0", name: "Coffee Name", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 0, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    
    
    var roastImg : [String] = ["Green Beans", "LightRoast", "MediumRoast", "DarkRoast"]
    var coffeeFlavours: [String] = ["FruityFlavour", "SpicesFlavour", "NuttyCocoaFlavour", "GreenVegetativeFlavour", "ChemicalFlavour", "SweetFlavour", "FloralFlavour", "SourFermentedFlavour", "PaperyMustyFlavour"]
    var flavours: Int = 9
    
    var comments: [Review] = [
        Review(sender: "Aaaaa", rating: 4, description: "asdfasdfadfasdf"),
        Review(sender: "Bbbb", rating: 3, description: "asdfasdfadfasdf"),
        Review(sender: "Ccccc", rating: 1, description: "asdfasdfadfasdf")
    ]
    
    
    
    var body: some View {
        ZStack(alignment: .bottom){
            NavigationView {
                ScrollView(.vertical, showsIndicators: true){
                    //Coffee image
                    Image(selectedCoffee.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: UIScreen.main.bounds.width * 1,
                            height: UIScreen.main.bounds.height * 0.3,
                            alignment: .topLeading
                        )
                        .clipped()
                    
                    
                    //Coffee title and price
                    VStack(alignment: .leading) {
                        Text(selectedCoffee.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding([.top, .leading], 15.0)
                        Text("Rp.\(selectedCoffee.price)")
                            .font(.body)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding([.leading, .bottom], 15.0)
                    }
                        .frame(
                            width: UIScreen.main.bounds.width * 0.9,
                            alignment: .topLeading
                        )
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    
                    //Roast
                    HStack {
                        Image(roastImg[selectedCoffee.roastLevel])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                        Spacer()
                    }
                        .padding(.leading, UIScreen.main.bounds.width * 0.055)
                        .padding([.top, .bottom], 5)
                    
                    
                    //Flavour
                    
                    HStack{
                        ForEach(coffeeFlavours, id: \.self) { flavour in
                            HStack {
                                Image(flavour)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 30)
                            }
                        }
                    }

                    
                    
                    
                    
                    
                    //Coffee Description
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                            .padding([.top, .leading], 15.0)
                            .padding(.bottom,5)
                        Text(selectedCoffee.description)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .padding([.leading, .bottom], 15.0)
                    }
                        .frame(
                            width: UIScreen.main.bounds.width * 0.9,
                            alignment: .topLeading
                        )
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    
                    //Comments
                    
                    ReviewGenerator(commentsArray: comments)
                    
                    
                    
                }
                    .background(
                        Image("Background")
                            .resizable()
                            .edgesIgnoringSafeArea(.all)
                            .scaledToFill()
                    )
                    .navigationBarTitle("Product Detail",displayMode: .inline)
                    .navigationBarItems(
                        leading:
                            Button(action: {
                                
                            }) {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            },
                        trailing:
                            HStack{
                                Button(action: {
                                    
                                }) {
                                    Image(systemName: "heart")
                                }
                                Button(action: {
                                    
                                }) {
                                    Image(systemName: "message.fill")
                                }
                            }
                    )
            }
            Spacer()
            AddToCartBtnView(ammount: 0)
        }
    }
}



struct ReviewGenerator: View {
    var commentsArray: [Review]
    
    var body: some View {
        VStack{
            HStack{
                Text("Review")
                    .font(.title)
                    .padding(.leading, 5.0)
                Spacer()
            }.frame(width: UIScreen.main.bounds.width * 0.9).padding([.top, .leading], 10).padding(.bottom, 5.0)
            
            VStack{
                ForEach(0 ..< commentsArray.count){ index in
                    ReviewSection(sender: self.commentsArray[index].sender , rating: self.commentsArray[index].rating, description: self.commentsArray[index].description).padding(.vertical, 5.0)
                }
            }
        }
        .padding(.bottom, 50.0)
    }
}

struct ReviewSection: View {
    var sender: String = "Aaaa"
    var rating: Int = 4
    var description: String = "asdfasdfasdfasdf asdfasd fasdf asdfasfasd fff"
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text(sender)
                .font(.headline)
                .multilineTextAlignment(.leading)
                .padding([.top, .leading], 15.0)
            Rating(rating: .constant(rating))
                .padding(.leading, 14.0)
            Text(description)
                .multilineTextAlignment(.leading)
                .padding(.leading, 15.0)
                .padding(.bottom,5)
        }
            .frame(
                width: UIScreen.main.bounds.width * 0.9,
                alignment: .leading
            )
            .background(Color.white)
            .cornerRadius(10)
    }
}

struct Rating: View {
    @Binding var rating: Int

    var label = ""

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<6) { number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        self.rating = number
                    }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}


struct AddToCartBtnView: View {
    @State var ammount: Int = 1

    var body: some View {
        HStack {
            Button(action: {
                
            }) {
                Text("Add to Cart")
                    .foregroundColor(Color.black)
            }
                .frame(width: UIScreen.main.bounds.width * 0.6, height: 45)
                .background(Color.init(.brown))
                .cornerRadius(10.0)
            
            HStack{
                TextField("0", value: $ammount, formatter: NumberFormatter()).padding(.leading, 10.0).keyboardType(UIKeyboardType.decimalPad)
                VStack{
                    Button(action: {
                        self.ammount += 1
                    }) {
                        Image(systemName: "chevron.up")
                    }
                    .padding(.trailing, 5.0)
                    Button(action: {
                        self.ammount -= (self.ammount<=1 ? 0 : 1)
                    }) {
                        Image(systemName: "chevron.down")
                    }
                    .padding(.trailing, 5.0)
                }
            }
                .frame(width: 70, height: 45)
                .background(Color.white)
                .overlay(
                    Rectangle()
                        .stroke(Color.black, lineWidth: 1)
                )
        }
    }
}


struct ProductDetail_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetail()
//        CommentSection(sender: "Aaaaa", rating: 4, description: "asdfasdfadfasdf")
    }
}
