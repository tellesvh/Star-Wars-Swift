import Foundation
import Alamofire

// MARK: - Species
class Species: Codable {
    let name, classification, designation, average_height: String?
    let skin_colors, hair_colors, eye_colors, average_lifespan: String?
    let homeworld: String?
    let language: String?
    let people, films: [String]?
    let created, edited: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name, classification, designation
        case average_height
        case skin_colors
        case hair_colors
        case eye_colors
        case average_lifespan
        case homeworld, language, people, films, created, edited, url
    }
    
    init(name: String?, classification: String?, designation: String?, average_height: String?, skin_colors: String?, hair_colors: String?, eye_colors: String?, average_lifespan: String?, homeworld: String?, language: String?, people: [String]?, films: [String]?, created: String?, edited: String?, url: String?) {
        self.name = name
        self.classification = classification
        self.designation = designation
        self.average_height = average_height
        self.skin_colors = skin_colors
        self.hair_colors = hair_colors
        self.eye_colors = eye_colors
        self.average_lifespan = average_lifespan
        self.homeworld = homeworld
        self.language = language
        self.people = people
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
    func responseSpecies(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Species>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
