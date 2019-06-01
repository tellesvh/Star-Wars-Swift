//
//  API.swift
//  Star Wars
//
//  Created by Victor Hugo Telles on 30/05/19.
//  Copyright © 2019 Victor Hugo Telles. All rights reserved.
//

import Foundation
import Alamofire

class API {
    
    static func getCharactersByQuery(
        query: String,
        success successBlock: @escaping ((CharactersResults) -> Void),
        failure failureBlock: @escaping ((String) -> Void)
        ) {
        
        let newQuery = query.replacingOccurrences(of: " ", with: "+")
        
        Alamofire.request("https://swapi.co/api/people/?search=" + newQuery).responseCharactersResults(completionHandler: { (response) in
            switch response.result {
            case .success:
                if let result = response.result.value {
                    successBlock(result)
                }
            case .failure(let error):
                failureBlock(error.localizedDescription)
            }
        })
    }
    
    static func getCharactersByUrl(
        url: String,
        success successBlock: @escaping ((CharactersResults) -> Void),
        failure failureBlock: @escaping ((String) -> Void)) {
        
        Alamofire.request(url).responseCharactersResults(completionHandler: { (response) in
            print(response)
            switch response.result {
            case .success:
                if let result = response.result.value {
                    successBlock(result)
                }
            case .failure(let error):
                failureBlock(error.localizedDescription)
            }
        })
    }
    
    static func getCharacterInfo(
        url: String,
        success successBlock: @escaping ((Character) -> Void),
        failure failureBlock: @escaping ((String) -> Void)) {
        
        Alamofire.request(url).responseCharacter(completionHandler: { (response) in
            print(response)
            switch response.result {
            case .success:
                if let result = response.result.value {
                    successBlock(result)
                }
            case .failure(let error):
                failureBlock(error.localizedDescription)
            }
        })
    }
    
    static func getHomeworldInfo(
        url: String,
        success successBlock: @escaping ((Homeworld) -> Void),
        failure failureBlock: @escaping ((String) -> Void)) {
        
        Alamofire.request(url).responseHomeworld(completionHandler: { (response) in
            print(response)
            switch response.result {
            case .success:
                if let result = response.result.value {
                    successBlock(result)
                }
            case .failure(let error):
                failureBlock(error.localizedDescription)
            }
        })
    }
    
    static func getFilmInfo(
        url: String,
        success successBlock: @escaping ((Film) -> Void),
        failure failureBlock: @escaping ((String) -> Void)) {
        
        Alamofire.request(url).responseFilm(completionHandler: { (response) in
            print(response)
            switch response.result {
            case .success:
                if let result = response.result.value {
                    successBlock(result)
                }
            case .failure(let error):
                failureBlock(error.localizedDescription)
            }
        })
    }
    
    static func getSpeciesInfo(
        url: String,
        success successBlock: @escaping ((Species) -> Void),
        failure failureBlock: @escaping ((String) -> Void)) {
        
        Alamofire.request(url).responseSpecies(completionHandler: { (response) in
            print(response)
            switch response.result {
            case .success:
                if let result = response.result.value {
                    successBlock(result)
                }
            case .failure(let error):
                failureBlock(error.localizedDescription)
            }
        })
    }
    
    static func getVehicleInfo(
        url: String,
        success successBlock: @escaping ((Vehicle) -> Void),
        failure failureBlock: @escaping ((String) -> Void)) {
        
        Alamofire.request(url).responseVehicle(completionHandler: { (response) in
            print(response)
            switch response.result {
            case .success:
                if let result = response.result.value {
                    successBlock(result)
                }
            case .failure(let error):
                failureBlock(error.localizedDescription)
            }
        })
    }
    
    static func getStarshipInfo(
        url: String,
        success successBlock: @escaping ((Starship) -> Void),
        failure failureBlock: @escaping ((String) -> Void)) {
        
        Alamofire.request(url).responseStarship(completionHandler: { (response) in
            print(response)
            switch response.result {
            case .success:
                if let result = response.result.value {
                    successBlock(result)
                }
            case .failure(let error):
                failureBlock(error.localizedDescription)
            }
        })
    }
    
}
