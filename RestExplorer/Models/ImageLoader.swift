//
//  ImageLoader.swift
//  RestExplorer
//
//  Created by Anna on 18.12.2021.
//  Copyright © 2021 Anna. All rights reserved.
//

import Foundation
import Combine

class ImageLoader: ObservableObject {
    
    var didChange = PassthroughSubject<Data, Never>()
    
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let safeData = data {
                DispatchQueue.main.async {
                    self.data = safeData
                }
            }
            
        }
        task.resume()
    }
}
