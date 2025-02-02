import Foundation

struct Country: Codable, Hashable {
    static func == (lhs: Country, rhs: Country) -> Bool {
        lhs.name.common == rhs.name.common
    }

    let name: Name
    let capital: [String]?
    let continents: [String]?
    let region: String
    let subregion: String?
    let population: Int
    let area: Double?
    let flags: Flags

    struct Name: Codable, Hashable {
        let common: String
        let official: String
    }

    struct Flags: Codable, Hashable {
        let png: String
        //var pngUrl: URL? { URL(string: png) }
    }
}
