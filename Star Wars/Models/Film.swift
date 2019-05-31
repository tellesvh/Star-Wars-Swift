import Foundation
import Alamofire

// MARK: - Film
class Film: Codable {
    let title: String?
    let episode_id: Int?
    let opening_crawl, director, producer, release_date: String?
    let characters, planets, starships, vehicles: [String]?
    let species: [String]?
    let created, edited: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case episode_id
        case opening_crawl
        case director, producer
        case release_date
        case characters, planets, starships, vehicles, species, created, edited, url
    }
    
    init(title: String?, episode_id: Int?, opening_crawl: String?, director: String?, producer: String?, release_date: String?, characters: [String]?, planets: [String]?, starships: [String]?, vehicles: [String]?, species: [String]?, created: String?, edited: String?, url: String?) {
        self.title = title
        self.episode_id = episode_id
        self.opening_crawl = opening_crawl
        self.director = director
        self.producer = producer
        self.release_date = release_date
        self.characters = characters
        self.planets = planets
        self.starships = starships
        self.vehicles = vehicles
        self.species = species
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
    func responseFilm(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Film>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
