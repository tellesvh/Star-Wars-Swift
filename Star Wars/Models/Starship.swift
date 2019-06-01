import Foundation
import Alamofire

// MARK: - Starship
class Starship: Codable {
    let name, model, manufacturer, cost_in_credits: String?
    let length, max_atmosphering_speed, crew, passengers: String?
    let cargoCapacity, consumables, hyperdriveRating, MGLT: String?
    let starship_class: String?
    let pilots, films: [String]?
    let created, edited: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name, model, manufacturer
        case cost_in_credits
        case length
        case max_atmosphering_speed
        case crew, passengers
        case cargoCapacity
        case consumables
        case hyperdriveRating
        case MGLT
        case starship_class
        case pilots, films, created, edited, url
    }
    
    init(name: String?, model: String?, manufacturer: String?, cost_in_credits: String?, length: String?, max_atmosphering_speed: String?, crew: String?, passengers: String?, cargoCapacity: String?, consumables: String?, hyperdriveRating: String?, MGLT: String?, starship_class: String?, pilots: [String]?, films: [String]?, created: String?, edited: String?, url: String?) {
        self.name = name
        self.model = model
        self.manufacturer = manufacturer
        self.cost_in_credits = cost_in_credits
        self.length = length
        self.max_atmosphering_speed = max_atmosphering_speed
        self.crew = crew
        self.passengers = passengers
        self.cargoCapacity = cargoCapacity
        self.consumables = consumables
        self.hyperdriveRating = hyperdriveRating
        self.MGLT = MGLT
        self.starship_class = starship_class
        self.pilots = pilots
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
    func responseStarship(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Starship>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
