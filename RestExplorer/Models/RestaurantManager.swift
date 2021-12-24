//
//  RestaurantManager.swift
//  RestExplorer
//
//  Created by Anna on 17.12.2021.
//  Copyright © 2021 Anna. All rights reserved.
//

import Foundation
import CoreLocation

class RestaurantManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var restaurants = [Restaurant]()
    @Published var lastLocation = CLLocationCoordinate2D(latitude: 49.842957, longitude: 24.031111)
    private let locationManager = CLLocationManager()
    private let keys = Keys()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            lastLocation = location.coordinate
            fetchRestaurants(coordinates: lastLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error with getting location data: \(error)")
        fetchRestaurants(coordinates: lastLocation)
    }
    
    func fetchRestaurants(coordinates: CLLocationCoordinate2D) {
        let urlString = "https://api.foursquare.com/v3/places/search?categories=13065&ll=\(coordinates.latitude),\(coordinates.longitude)"
        performRequest(with: urlString)
    }
    
    func fetchRestaurants(coordinates: CLLocationCoordinate2D, categoryID: String) {
        let urlString = "https://api.foursquare.com/v3/places/search?ll=\(coordinates.latitude),\(coordinates.longitude)&categories=\(categoryID)"
        performRequest(with: urlString)
    }
    
    func fetchRestaurants(coordinates: CLLocationCoordinate2D, query: String) {
        let urlString = "https://api.foursquare.com/v3/places/search?categories=13065&ll=\(coordinates.latitude),\(coordinates.longitude)&query=\(query)"
        performRequest(with: urlString)
    }
    
    func fetchPhoto(venueID: String) {
        let urlString = "https://api.foursquare.com/v3/places/\(venueID)/photos"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        let headers = [
            "Accept": "application/json",
            "Authorization": "\(keys.apiKey)"
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
                    self.parseJSON(safeData)
                }
            }
            dataTask.resume()
        }
    }
    
    func parseJSON(_ requestData: Data) {
        let decoder = JSONDecoder()
        do {
            let resultData = try decoder.decode(Results.self, from: requestData)
            DispatchQueue.main.async {
                self.restaurants = resultData.results
            }
            
        } catch {
            print("Error with decoding data: \(error)")
        }
    }
    
}
