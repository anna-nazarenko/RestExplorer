//
//  PhotoData.swift
//  RestExplorer
//
//  Created by Anna on 16.12.2021.
//  Copyright © 2021 Anna. All rights reserved.
//

import Foundation

struct Photo: Codable, Identifiable, Hashable {
    let id: String
    let prefix: String
    let suffix: String
    let width: Int
    let height: Int
}
