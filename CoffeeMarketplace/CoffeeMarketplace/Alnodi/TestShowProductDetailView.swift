//
//  TestShowProductDetailView.swift
//  CoffeeMarketplace
//
//  Created by Alnodi Adnan on 30/07/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI
import CloudKit

struct TestProductDetailView: View {
    @Binding var selectedProduct : ProductData
    @Binding var isShowingProductDetailView : Bool
    @State var isShowingUpdateProductView = false
    @Binding var productListConverted : [ProductData]
    
    @ObservedObject var cart : CartB = .shared
    
    var body: some View {
        VStack{
            NavigationLink(destination: TestUpdateProductView(updatedProductData: $selectedProduct), isActive: $isShowingUpdateProductView){
                EmptyView()
            }
            
            Image(uiImage: selectedProduct.image!)
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
            
            Text("Nama Produk : \(selectedProduct.name)")
            Text("Harga : Rp. \(selectedProduct.price)")
            Text("Deskripsi : ")
            Text(selectedProduct.description)
            
            Button(action: {
                self.isShowingProductDetailView = false
                //delete the selected product
                self.deleteSelectedProduct(productToBeDeleted: self.selectedProduct)
            }) {
                Text("Delete")
            }
            
            Button(action: {
                self.isShowingUpdateProductView = true
                
            }) {
                Text("Update Product")
            }
            
            Button(action: {
                //self.isShowingUpdateProductView = true
                Cart.productList.append(self.selectedProduct)
                self.cart.productList.append(self.selectedProduct)
                print("Added to cart")
            }) {
                Text("Add to cart")
            }
        }
    }
    
    func deleteSelectedProduct(productToBeDeleted: ProductData){
        
        
        let database = CKContainer.default().publicCloudDatabase
        
        database.delete(withRecordID: productToBeDeleted.id) { (recordID, err) in
            if let err = err {
                print(err.localizedDescription)
            }
            
            print("Product bernama \(productToBeDeleted.name) berhasil dihapus")
            
        }
    }
}

//struct TestShowProductDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestShowProductDetailView()
//    }
//}
