//
//  SelectionRows.swift
//  myShop-test
//
//  Created by Calvin Dalenta on 23/07/20.
//  Copyright © 2020 Apple Academy. All rights reserved.
//

import SwiftUI

struct SelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark").foregroundColor(Color.secondary)
                }
            }
        }
    }
}

//struct SelectionRow_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectionRow()
//    }
//}
