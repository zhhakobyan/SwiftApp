//
//  Movieswift
//  Sample
//
//  Created by Zhanna on 27.01.24.
//

import Foundation

// MARK: - MovieElement
struct MovieElement: Codable, Identifiable {
    let id = UUID().uuidString
    let score: Double
    let movie: Movie
    
    enum CodingKeys: String, CodingKey {
        case id, score
        case movie = "show"
    }
}

// MARK: - Movie
struct Movie: Codable {
    let id: Int
    let url: String?
    let name: String?
    let type: TypeEnum?
    let language: Language?
    let genres: [String]?
    let status: Status?
    let runtime, averageRuntime: Int?
    let premiered, ended: String?
    let officialSite: String?
    let schedule: Schedule?
    let rating: Rating?
    let weight: Int?
    let network, webChannel: Network?
    let dvdCountry: JSONNull?
    let externals: Externals?
    let image: Image?
    let summary: String?
    let updated: Int?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status,
             runtime, averageRuntime, premiered, ended,
             officialSite, schedule, rating, weight, network,
             webChannel, dvdCountry, externals, image, summary, updated
        case links = "_links"
    }
}

// MARK: - Externals
struct Externals: Codable {
    let tvrage, thetvdb: Int?
    let imdb: String?
}

// MARK: - Image
struct Image: Codable {
    let medium, original: String?
}

enum Language: Codable {
    typealias RawValue = String
    case value(name: String?)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let language = try? container.decode(String.self)
        self = .value(name: language)
    }
}

// MARK: - Links
struct Links: Codable {
    let linksSelf: PreviousEpisode?
    let previousEpisode: PreviousEpisode?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case previousEpisode
    }
}

// MARK: - PreviousEpisode
struct PreviousEpisode: Codable {
    let href: String?
}

// MARK: - Network
struct Network: Codable {
    let id: Int?
    let name: String?
    let country: Country?
    let officialSite: String?
}

// MARK: - Country
struct Country: Codable {
    let name, code, timezone: String?
}

// MARK: - Rating
struct Rating: Codable {
    let average: Double?
}

// MARK: - Schedule
struct Schedule: Codable {
    let time: String?
    let days: [String]?
}

enum Status: String, Codable {
    case ended = "Ended"
    case running = "Running"
    case toBeDetermined = "To Be Determined"
    case inDevelopment = "In Development"
    case other
}

enum TypeEnum: Codable {
    typealias RawValue = String
    case value(type: String?)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let type = try? container.decode(String.self)
        self = .value(type: type)
    }
}

// MARK: - Encode/decode helpers
class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self,
                                             DecodingError.Context(codingPath: decoder.codingPath,
                                                                   debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
