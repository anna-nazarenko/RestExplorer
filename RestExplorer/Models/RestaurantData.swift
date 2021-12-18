//
//  RestaurantData.swift
//  RestExplorer
//
//  Created by Anna on 17.12.2021.
//  Copyright © 2021 Anna. All rights reserved.
//

import Foundation

struct Results: Codable {
    let results: [Restaurant]
}

struct Restaurant: Codable, Identifiable {
    var id: String {
        return fsq_id
    }
    let fsq_id: String
    let categories: [Category]
    let location: Location
    let name: String
}

struct Category: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
}

struct Location: Codable {
    let address: String
    let locality: String
}
