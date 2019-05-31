// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let homeworld = try? newJSONDecoder().decode(Homeworld.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseHomeworld { response in
//     if let homeworld = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - Homeworld
class Homeworld: Codable {
    let name, rotation_period, orbital_period, diameter: String?
    let climate, gravity, terrain, surface_water: String?
    let population: String?
    let residents, films: [String]?
    let created, edited: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case rotation_period
        case orbital_period
        case diameter, climate, gravity, terrain
        case surface_water
        case population, residents, films, created, edited, url
    }
    
    init(name: String?, rotation_period: String?, orbital_period: String?, diameter: String?, climate: String?, gravity: String?, terrain: String?, surface_water: String?, population: String?, residents: [String]?, films: [String]?, created: String?, edited: String?, url: String?) {
        self.name = name
        self.rotation_period = rotation_period
        self.orbital_period = orbital_period
        self.diameter = diameter
        self.climate = climate
        self.gravity = gravity
        self.terrain = terrain
        self.surface_water = surface_water
        self.population = population
        self.residents = residents
        self.films = films
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
    func responseHomeworld(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Homeworld>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
