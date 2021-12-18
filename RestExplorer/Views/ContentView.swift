//
//  ContentView.swift
//  RestExplorer
//
//  Created by Anna on 15.12.2021.
//  Copyright © 2021 Anna. All rights reserved.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @ObservedObject var restaurantManager = RestaurantManager()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                CategoryRow()
                SearchBar(text: $searchText)
                RestaurantList()
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
        .environmentObject(restaurantManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
