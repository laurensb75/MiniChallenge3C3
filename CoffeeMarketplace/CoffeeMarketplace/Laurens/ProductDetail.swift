//
//  ProductDetail.swift
//  CoffeeMarketplace
//
//  Created by Laurens Bryan Cahyana on 22/07/20.
//  Copyright ©️ 2020 laurens bryan. All rights reserved.
//

import SwiftUI

struct ProductDetail: View {
    @Environment(\.presentationMode) var presentation
    
    
    var selectedCoffee: Coffeee = .init(id: "0", name: "Coffee Name", description: "akdfhlaks dfalskdf askjf alksdfas dlfas dfasdk fahlskd fasfasdlfa a sdf alksdj fahlks dflajs alskjh a lahsdf asjkdf as kfd", price: 0, roastLevel: 1, flavour: [true,true,true,true,true,true,true,true,true], image: "Coffee")
    
    var selectedProduct = ProductData(name: "Coffee Name", description: "This is coffee description", price: 0, stock: 1, beanType: "green", roastType: "Dark", flavour: ["1", "2"], image: UIImage(named: "Coffee"), id: nil)
    
    var roastImg : [String] = ["Green Beans", "LightRoast", "MediumRoast", "DarkRoast"]
    
    var comments: [Review] = [
        Review(sender: "Aaaaa", rating: 4, description: "asdfasdfadfasdf"),
        Review(sender: "Bbbb", rating: 3, description: "asdfasdfadfasdf"),
        Review(sender: "Ccccc", rating: 1, description: "asdfasdfadfasdf")
    ]
    
    @State var averageRating: Int = 4
    
    
    var body: some View {
        VStack{
            ScrollView(.vertical){
                //Coffee image
                Image(uiImage: selectedProduct.image!) //Image(selectedCoffee.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        width: UIScreen.main.bounds.width * 1,
                        height: UIScreen.main.bounds.height * 0.3,
                        alignment: .topLeading
                )
                    .clipped()
                
                //Coffee title and price
                VStack(alignment: .leading) {
                    Text(selectedProduct.name) //Text(selectedCoffee.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading], 15.0)
                    Text("Rp. \(selectedProduct.price)") //Text("Rp.\(selectedCoffee.price)")
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
                    Image(roastImg[convertRoastType(rawRoastType: selectedProduct.roastType)])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                    Spacer()
                }
                .padding(.leading, UIScreen.main.bounds.width * 0.055)
                .padding([.top, .bottom], 5)
                
                //Flavour
                //ProductDetailCoffeeFlavourView(selectedCoffeeFlavours: selectedCoffee.flavour)
                
                ProductDetailCoffeeFlavourView(ReceivedCoffeeFlavour: selectedProduct.flavour)
                
                
                //rating overall + favourite button
                HStack{
                    Rating(rating: $averageRating)
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Image(systemName: "heart").resizable().foregroundColor(Color.red).frame(width: 30, height: 30)
                    }
                }.padding(.horizontal, 25.0)
                
                
                //Coffee Description
                //ProductDetailCoffeeDescription(selectedCoffeeDescription: selectedCoffee.description)
                
                ProductDetailCoffeeDescription(selectedCoffeeDescription: selectedProduct.description)
                
                //Comments
                ReviewGenerator(commentsArray: comments)
            }
            AddToCartBtnView(ammount: 0, selectedProduct: selectedProduct)
                .padding(.bottom)
        }.background(Image("Background").resizable().edgesIgnoringSafeArea(.all).scaledToFill().edgesIgnoringSafeArea(.all))
            .onAppear(){
                print("nama produk: \(self.selectedProduct.name) \nroastType: \(self.selectedProduct.roastType)")
        }
        .navigationBarTitle("Detail", displayMode: .inline)
    }
    
    func convertRoastType(rawRoastType: String) -> Int{
        switch rawRoastType {
        case "Light":
            return  0
        case "Medium":
            return 1
        case "Dark":
            return 2
        case "Very Dark":
            return 3
        default:
            print("0")
            return 0
            
        }
    }
}





struct ProductDetailCoffeeFlavourView: View {
    //var selectedCoffeeFlavours: [Bool]
    
    var coffeeFlavours: [String] = ["FruityFlavour", "SpicesFlavour", "GreenVegetativeFlavour", "NuttyCocoaFlavour", "ChemicalFlavour", "SweetFlavour", "FloralFlavour", "SourFermentedFlavour", "PaperyMustyFlavour"]
    
    var ReceivedCoffeeFlavour : [String] = []
    @ObservedObject var counter : Counter = .shared
    //var horizontalList : [Int] = []
    
    var body: some View{
        
        VStack{
            ForEach(0 ..< verticalRowNeeded()) { flavourVertical in
                HStack {
                    ForEach(0 ..< 1, id: \.self) { flavourHorizontal in
                        
                        Image(self.adjustFlavour(rawCoffeeFlavours: self.ReceivedCoffeeFlavour)[(flavourVertical * 3) + flavourHorizontal])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                            .onAppear(){
                                self.counter.count += 1
                        }
                        
                    }
                    Spacer()
                }
                
            }
        }.padding(.leading, 22.0)
    }
    
    func adjustFlavour(rawCoffeeFlavours : [String]) -> [String]{
        var adjustedCoffeeFlavours : [String] = []
        
        for index in 0 ..< rawCoffeeFlavours.count {
            switch rawCoffeeFlavours[index] {
            case "Fruity":
                adjustedCoffeeFlavours.append("FruityFlavour")
            case "Spices":
                adjustedCoffeeFlavours.append("SpicesFlavour")
            case "Green/Vegetative":
                adjustedCoffeeFlavours.append("GreenVegetativeFlavour")
            case "Nutty/Cocoa":
                adjustedCoffeeFlavours.append("NuttyCocoaFlavour")
            case "Chemical/Industrial":
                adjustedCoffeeFlavours.append("ChemicalFlavour")
            case "Sweet":
                adjustedCoffeeFlavours.append("SweetFlavour")
            case "Floral":
                adjustedCoffeeFlavours.append("FloralFlavour")
            case "Sour/Fermented":
                adjustedCoffeeFlavours.append("SourFermentedFlavour")
            case "Papery/Musty":
                adjustedCoffeeFlavours.append("PaperyMustyFlavour")
            default:
                print("Invalid Flavour")
            }
        }
        
        return adjustedCoffeeFlavours
    }
    
    func verticalRowNeeded() -> Int{
        if(ReceivedCoffeeFlavour.count % 3 == 0){
            print("Vertical needed: \(ReceivedCoffeeFlavour.count / 3)")
            return ReceivedCoffeeFlavour.count / 3
        }
        else {
            print("Vertical needed: \((ReceivedCoffeeFlavour.count / 3) + 1)")
            return (ReceivedCoffeeFlavour.count / 3) + 1
        }
    }
    
    func horizontalRowNeeded() -> [Int]{
        var resultList : [Int] = []
        
        if counter.count <= 3 {
            resultList.append(counter.count)
            print(resultList)
            return resultList
            
        }
        else{
            while counter.count >= 3 {
                resultList.append(3)
                counter.count -= 3
            }
            resultList.append(counter.count)
            print(resultList)
            return resultList
        }
    }
    
    
}

struct ProductDetailCoffeeFlavourViewB {
    var coffeeFlavours: [String] = ["FruityFlavour", "SpicesFlavour", "GreenVegetativeFlavour", "NuttyCocoaFlavour", "ChemicalFlavour", "SweetFlavour", "FloralFlavour", "SourFermentedFlavour", "PaperyMustyFlavour"]
    
    var ReceivedCoffeeFlavour : [String] = []
    var indexVertical : Int = 0
    var indexHorizontal : Int = 0
    
    var body : some View{
        Image(self.adjustFlavour(rawCoffeeFlavours: self.ReceivedCoffeeFlavour)[(self.indexVertical * 3) + self.indexHorizontal])
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 30)
    }
    
    
    
    
    func adjustFlavour(rawCoffeeFlavours : [String]) -> [String]{
        var adjustedCoffeeFlavours : [String] = []
        
        for index in 0 ..< rawCoffeeFlavours.count {
            switch rawCoffeeFlavours[index] {
            case "Fruity":
                adjustedCoffeeFlavours.append("FruityFlavour")
            case "Spices":
                adjustedCoffeeFlavours.append("SpicesFlavour")
            case "Green/Vegetative":
                adjustedCoffeeFlavours.append("GreenVegetativeFlavour")
            case "Nutty/Cocoa":
                adjustedCoffeeFlavours.append("NuttyCocoaFlavour")
            case "Chemical/Industrial":
                adjustedCoffeeFlavours.append("ChemicalFlavour")
            case "Sweet":
                adjustedCoffeeFlavours.append("SweetFlavour")
            case "Floral":
                adjustedCoffeeFlavours.append("FloralFlavour")
            case "Sour/Fermented":
                adjustedCoffeeFlavours.append("SourFermentedFlavour")
            case "Papery/Musty":
                adjustedCoffeeFlavours.append("PaperyMustryFlavour")
            default:
                print("Invalid Flavour")
            }
        }
        
        return adjustedCoffeeFlavours
    }
}


struct ProductDetailCoffeeDescription: View {
    var selectedCoffeeDescription: String
    
    
    var body: some View{
        VStack(alignment: .leading) {
            Text("Description")
                .font(.headline)
                .multilineTextAlignment(.leading)
                .padding([.top, .leading], 15.0)
                .padding(.bottom,5)
            Text(selectedCoffeeDescription)
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
    @Environment(\.presentationMode) var presentation
    @State var ammount: Int = 1
    
    @ObservedObject var cart : Cart = .shared
    var selectedProduct = ProductData()
    
    var body: some View {
        HStack {
            Button(action: {
                self.cart.productList.append(self.selectedProduct)
                self.cart.ammountList.append(self.ammount)
                self.presentation.wrappedValue.dismiss()
                print("Added to cart")
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


//VStack{
//            ForEach(0..<3) { flavourVertical in
//                HStack {
//                    ForEach(0..<3) { flavourHorizontal in
//                        Image(self.coffeeFlavours[(flavourVertical * 3) + flavourHorizontal])
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(height: 30)
//
//                    }
//                    Spacer()
//                }
//            }
//        }.padding(.leading, 22.0)
