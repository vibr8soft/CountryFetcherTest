import Foundation
@testable import ArtmCountriesTest

class MockGetAllCountriesSortedByNameUseCase: IGetAllCountriesSortedByNameUseCase {
    var result: Result<[Country], Error>

    init(result: Result<[Country], Error>) {
        self.result = result
    }

    func getAllCountriesSortedByName() async -> Result<[Country], Error> {
        return result
    }
}
