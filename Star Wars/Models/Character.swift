// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let character = try? newJSONDecoder().decode(Character.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseCharacter { response in
//     if let character = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - Character
class Character: Codable {
    let name, height, mass, hair_color: String?
    let skin_color, eye_color, birth_year, gender: String?
    var homeworld: String?
    let films, species, vehicles, starships: [String]?
    let created, edited: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name, height, mass
        case hair_color
        case skin_color
        case eye_color
        case birth_year
        case gender, homeworld, films, species, vehicles, starships, created, edited, url
    }
    
    init(name: String?, height: String?, mass: String?, hair_color: String?, skin_color: String?, eye_color: String?, birth_year: String?, gender: String?, homeworld: String?, films: [String]?, species: [String]?, vehicles: [String]?, starships: [String]?, created: String?, edited: String?, url: String?) {
        self.name = name
        self.height = height
        self.mass = mass
        self.hair_color = hair_color
        self.skin_color = skin_color
        self.eye_color = eye_color
        self.birth_year = birth_year
        self.gender = gender
        self.homeworld = homeworld
        self.films = films
        self.species = species
        self.vehicles = vehicles
        self.starships = starships
        self.created = created
        self.edited = edited
        self.url = url
    }
}

// MARK: - Alamofire response handlers

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try newJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseCharacter(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Character>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
