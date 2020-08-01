//
//  TestEnvironmentView.swift
//  CoffeeMarketplace
//
//  Created by Alnodi Adnan on 01/08/20.
//  Copyright © 2020 laurens bryan. All rights reserved.
//

import SwiftUI

struct TestEnvironmentView: View {
    @EnvironmentObject var settings: UserSettings

    var body: some View {
        NavigationView {
            VStack {
                // A button that writes to the environment settings
                Button(action: {
                    self.settings.score += 1
                }) {
                    Text("Increase Score")
                }

                NavigationLink(destination: DetailView().environmentObject(settings)) {
                    Text("Show Detail View")
                }
            }
        }
    }
}

struct DetailView: View {
    @EnvironmentObject var settings: UserSettings

    var body: some View {
        // A text view that reads from the environment settings
        Text("Score: \(settings.score)")
    }
}

class UserSettings: ObservableObject {
    @Published var score = 0
}

struct TestEnvironmentView_Previews: PreviewProvider {
    static var previews: some View {
        TestEnvironmentView()
    }
}
