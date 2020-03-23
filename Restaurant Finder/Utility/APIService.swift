//
//  APIService.swift
//  Restaurant Finder
//
//  Created by Musaddique Billah Talha on 3/19/20.
//

import Foundation
import FoursquareAPIClient
import CoreLocation

class APIService {
    
    static let shared = APIService()
    
    func searchVenuesWithCoordinate(latitude: Double = Constants.FourSquarePlaceAPI.DEFAULT_LAT,
                     longitude: Double = Constants.FourSquarePlaceAPI.DEFAULT_LON,
                     categoryID: String = Constants.FourSquarePlaceAPI.CATEGORY_FOOD,
                     radius: Int = Constants.FourSquarePlaceAPI.RADIUS,
                     limit: Int = Constants.FourSquarePlaceAPI.LIMIT,
                     query: String? = nil, completion: @escaping ([Venue]?, Error?) -> Void ) {
        
        let placeClient = FoursquareAPIClient(clientId: Constants.FourSquarePlaceAPI.CLIENT_ID, clientSecret: Constants.FourSquarePlaceAPI.CLIENT_SERCET)
        
        var parameter = [
          "ll": "\(latitude),\(longitude)",
            "limit": "\(limit)",
            "radius": "\(radius)",
          "categoryId": categoryID,
        ]
        
        if let query = query {
          parameter["query"] = query
        }
        
        placeClient.request(path: "venues/search", parameter: parameter) { [weak self] result in
            switch result {
            case let .success(data):
                
                let decoder: JSONDecoder = JSONDecoder()
                do {
                    let response = try decoder.decode(Response<SearchResponse>.self, from: data)
                    completion(response.response.venues, nil)
                } catch {
                    
                    print(error.localizedDescription)
                    
                    completion(nil, error)
                }

            case let .failure(error):
                // Error handling
                switch error {
                case let .connectionError(connectionError):
                    print(connectionError)
                    completion(nil, connectionError)
                case let .responseParseError(responseParseError):
                    completion(nil, responseParseError)
                    print(responseParseError)
                case let .apiError(apiError):
                    completion(nil, apiError)
                    print(apiError.errorType)
                    print(apiError.errorDetail)
                }
            }
        }
      }
}



