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

}
