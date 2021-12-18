//
//  CategoryRow.swift
//  RestExplorer
//
//  Created by Anna on 17.12.2021.
//  Copyright © 2021 Anna. All rights reserved.
//

import SwiftUI

struct CategoryRow: View {
    @EnvironmentObject var restaurantManager: RestaurantManager
    
    let categories = [
        CategoryModel(name: "Vegetarian", id: "13377"),
        CategoryModel(name: "Seafood", id: "13338"),
        CategoryModel(name: "Fast Food", id: "13145"),
        CategoryModel(name: "Ukrainian", id: "13374"),
        CategoryModel(name: "Italian", id: "13236"),
        CategoryModel(name: "Japanese", id: "13263"),
        CategoryModel(name: "Turkish", id: "13356"),
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 25) {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        self.restaurantManager.fetchRestaurants(coordinates: self.restaurantManager.lastLocation, categoryID: category.id)
                    }) {
                        VStack {
                            Image(category.id)
                            Text(category.name)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow()
            .environmentObject(RestaurantManager())
    }
}
