import XCTest
@testable import ArtmCountriesTest

class MockCountryService: CountryServiceProtocol {
    var result: Result<[Country], Error> = .success([])
    
    func fetchAllCountryList() async throws -> [Country] {
        switch result {
        case .success(let countries):
            return countries
        case .failure(let error):
            throw error
        }
    }
}
