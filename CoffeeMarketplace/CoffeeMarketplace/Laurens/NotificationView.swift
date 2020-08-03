//
//  NotificationView.swift
//  testSwiftUI
//
//  Created by Laurens Bryan Cahyana on 03/08/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI

struct NotificationView: View {
    var currentCart: Cart = .init()
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach (0 ..< currentCart.productList.count, id: \.self) { index in
                        NavigationLink(destination: NotificationDetail()) {
                            NotificationItemView()
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
                    .padding()
            }
                .background(Image("Background").scaledToFill().edgesIgnoringSafeArea(.all))
                .navigationBarTitle("Notification", displayMode: .inline)
        }
    }
}

    
struct NotificationItemView: View {
    var selectedCoffee: ProductData = .init()
    var selectedBuyer: UserData = .init()
    var selectedItemQuantity: Int = 1
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("There is a buyer!")
                    .font(.title)
                    .padding([.leading, .bottom], 5.0)
                Text("\(selectedCoffee.name)")
                    .font(.headline)
                    .padding([.leading, .bottom], 5.0)
                Text("Quantity: \(selectedItemQuantity), Total price: Rp.\(selectedCoffee.price * selectedItemQuantity),-")
                    .font(.body)
                    .padding([.leading, .bottom], 5.0)
            }
                .padding([.top, .leading, .bottom], 5.0)
            Spacer()
            Image("WhatsappIcon")
                .resizable()
                .padding(.trailing, 5.0)
                .frame(width: 50.0, height: 50.0)
                .foregroundColor(Color.blue)
                .onTapGesture() {
                    UIApplication.shared.open(URL(string: "https://wa.me/\(self.selectedBuyer.number)?text=I'm%20interested%20in%20buying%20your%20coffee%20for%20sale")!)
                }
//            Button(action: {
//                openURL(URL(string: "https://wa.me/15551234567?text=I'm%20interested%20in%20your%20car%20for%20sale")!)
//            }) {
//                Image(systemName: "message")
//                    .resizable()
//                    .padding(.trailing, 5.0)
//                    .frame(width: 50.0, height: 50.0)
//                    .foregroundColor(Color.blue)
//            }
//                .padding([.top, .bottom, .trailing], 5.0)
        }
            .background(Color.white)
            .cornerRadius(20)
            .frame(width: UIScreen.main.bounds.width * 0.9)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 1)
            )
    }
}

struct NotificationDetail: View {
    var selectedCoffee: ProductData = .init()
    var selectedBuyer: UserData = .init()
    var selectedItemQuantity: Int = 1
    var selectedTransactionProgress = 1
    
    var body: some View {
        VStack {
            //coffee brief detail
            HStack {
                Image(uiImage: selectedCoffee.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 125.0, height: 125.0)
                    .clipped()
                    .cornerRadius(10.0)
                    .padding()
                VStack(alignment: .leading) {
                    Text("\(selectedCoffee.name)")
                        .font(.title)
                    Text("Quantity  :  \(selectedItemQuantity)")
                        .font(.body)
                    Text("Price        :  \(selectedCoffee.price)")
                        .font(.body)
                    Text("Transaction ID")
                        .font(.footnote)
                    
                }
                .padding(.trailing, 5.0)
                Spacer()
            }
                .background(Color.white)
                .cornerRadius(20.0)
                .frame(width: UIScreen.main.bounds.width * 0.9)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            //buyer contact
            HStack {
                VStack(alignment: .leading) {
                    Text("\(selectedBuyer.name)")
                        .font(.title)
                    Text("\(selectedBuyer.number)")
                        .font(.body)
                }
                .padding([.top, .leading, .bottom])
                Spacer()
                Image("WhatsappIcon")
                    .resizable()
                    .padding()
                    .frame(width: 100.0, height: 100.0)
                    .foregroundColor(Color.blue)
                    .onTapGesture() {
                        UIApplication.shared.open(URL(string: "https://wa.me/\(self.selectedBuyer.number)?text=I'm%20interested%20in%20buying%20your%20coffee%20for%20sale")!)
                    }
            }
                .background(Color.white)
                .cornerRadius(20.0)
                .frame(width: UIScreen.main.bounds.width * 0.9)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 1)
                )
            
            //transaction process
            VStack {
                HStack {
                    VStack {
                        Text("Transaction Process")
                            .font(.title)
                        HStack{
                            Text("Ordered")
                            Spacer()
                            Image(systemName: (selectedTransactionProgress >= 1) ? "checkmark" : "")
                                .foregroundColor(/*@START_MENU_TOKEN@*/.green/*@END_MENU_TOKEN@*/)
                                .padding(.trailing)
                        }
                        .padding()
                        HStack{
                            Text("Confirmed")
                            Spacer()
                            Image(systemName: (selectedTransactionProgress >= 2) ? "checkmark" : "")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.green/*@END_MENU_TOKEN@*/)
                            .padding(.trailing)
                        }
                        .padding()
                        HStack{
                            Text("Sent")
                            Spacer()
                            Image(systemName: (selectedTransactionProgress >= 3) ? "checkmark" : "")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.green/*@END_MENU_TOKEN@*/)
                            .padding(.trailing)
                        }
                        .padding()
                        HStack{
                            Text("Arrived")
                            Spacer()
                            Image(systemName: (selectedTransactionProgress >= 4) ? "checkmark" : "")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.green/*@END_MENU_TOKEN@*/)
                            .padding(.trailing)
                        }
                        .padding()
                        HStack{
                            Text("Done")
                            Spacer()
                            Image(systemName: (selectedTransactionProgress >= 5) ? "checkmark" : "")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.green/*@END_MENU_TOKEN@*/)
                            .padding(.trailing)
                        }
                        .padding()
                    }
                }
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 1)
                    )
                
                //spacing befor button
                Spacer()
                
                //buttons
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Confirm Order Payment")
                        .foregroundColor(Color.white)
                }
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 25)
                    .background(Color.blue)
                    .cornerRadius(12.5)
                    .padding(.top)
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Item sent")
                        .foregroundColor(Color.white)
                }
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 25)
                    .background(Color.blue)
                    .cornerRadius(12.5)
                .padding(.top)
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Item Arrived")
                        .foregroundColor(Color.white)
                }
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 25)
                    .background(Color.blue)
                    .cornerRadius(12.5)
                    .padding(.top)
            }
        }
        .padding(.top)
            .background(Image("Background").edgesIgnoringSafeArea(.all))
    }
}


struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }
}


struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}


struct UserData {
    var name: String = "User Name"
    var number: String = "62811221655"
}
