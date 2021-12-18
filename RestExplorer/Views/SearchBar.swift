//
//  SearchBar.swift
//  RestExplorer
//
//  Created by Anna on 17.12.2021.
//  Copyright © 2021 Anna. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    @EnvironmentObject var restaurantManager: RestaurantManager
    @Binding var text: String
    
    
    var body: some View {
        HStack {
            TextField("Search …", text: $text) {
                self.restaurantManager.fetchRestaurants(coordinates: self.restaurantManager.lastLocation, query: self.text)
            }
                .disableAutocorrection(true)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        Button(action: {
                            self.text = ""
                            self.restaurantManager.fetchRestaurants(coordinates: self.restaurantManager.lastLocation)
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                )
                .padding(.horizontal, 10)
        }
        .padding(.bottom, 5)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Search …"))
        .environmentObject(RestaurantManager())
    }
}
