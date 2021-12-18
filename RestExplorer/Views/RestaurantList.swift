//
//  RestaurantList.swift
//  RestExplorer
//
//  Created by Anna on 17.12.2021.
//  Copyright © 2021 Anna. All rights reserved.
//

import SwiftUI

struct RestaurantList: View {
    @EnvironmentObject var restaurantManager: RestaurantManager
    
    var body: some View {
        List(restaurantManager.restaurants) { restaurant in
            NavigationLink(destination: DetailView(restaurant: restaurant)) {
                VStack(alignment: .leading) {
                    Text(restaurant.name)
                        .font(.title)
                    Text(restaurant.categories[0].name)
                    Text("\(restaurant.location.address), \(restaurant.location.locality)")
                }
            }
        }
    }
}

struct RestaurantList_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantList()
        .environmentObject(RestaurantManager())
    }
}
