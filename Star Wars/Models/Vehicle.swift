import Foundation
import Alamofire

// MARK: - Vehicle
class Vehicle: Codable {
    let name, model, manufacturer, cost_in_credits: String?
    let length, max_atmosphering_speed, crew, passengers: String?
    let cargo_capacity, consumables, vehicle_class: String?
    let pilots, films: [String]?
    let created: String?
    let edited: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name, model, manufacturer
        case cost_in_credits
        case length
        case max_atmosphering_speed
        case crew, passengers
        case cargo_capacity
        case consumables
        case vehicle_class
        case pilots, films, created, edited, url
    }
    
    init(name: String?, model: String?, manufacturer: String?, cost_in_credits: String?, length: String?, max_atmosphering_speed: String?, crew: String?, passengers: String?, cargo_capacity: String?, consumables: String?, vehicle_class: String?, pilots: [String]?, films: [String]?, created: String?, edited: String?, url: String?) {
        self.name = name
        self.model = model
        self.manufacturer = manufacturer
        self.cost_in_credits = cost_in_credits
        self.length = length
        self.max_atmosphering_speed = max_atmosphering_speed
        self.crew = crew
        self.passengers = passengers
        self.cargo_capacity = cargo_capacity
        self.consumables = consumables
        self.vehicle_class = vehicle_class
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
    func responseVehicle(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Vehicle>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
