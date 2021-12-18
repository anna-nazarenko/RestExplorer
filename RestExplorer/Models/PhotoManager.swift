//
//  PhotoManager.swift
//  RestExplorer
//
//  Created by Anna on 16.12.2021.
//  Copyright © 2021 Anna. All rights reserved.
//

import Foundation

class PhotoManager: ObservableObject {
    @Published var photos = [Photo]()
    
    func fetchPhoto(id: String) {
        let urlString = "https://api.foursquare.com/v3/places/\(id)/photos"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        let headers = [
            "Accept": "application/json",
            "Authorization": "fsq3djAMPP16j/WiUT5fQZohN7kTXzI8hI/7538XTyVmjj4="
        ]
        
        if let url = NSURL(string: urlString) as URL? {
            let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
                if error != nil {
                    print("Error with request performing: \(error!)")
                    return
                }
                
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let resultData = try decoder.decode([Photo].self, from: safeData)
                        DispatchQueue.main.async {
                            self.photos = resultData
                        }
                        
                    } catch {
                        print("Error with decoding data: \(error)")
                    }
                }
            }
            dataTask.resume()
        }
    }
}
