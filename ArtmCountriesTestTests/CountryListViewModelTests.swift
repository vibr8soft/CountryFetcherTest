import XCTest
@testable import ArtmCountriesTest

class CountryListViewModelTests: XCTestCase {
    
    func testLoadCountries_Success() async {
        let mockCountries = [
            Country(name: .init(common: "Canada",
                                official: "Canada"),
                    capital: ["Ottawa"],
                    continents: [],
                    region: "Americas",
                    subregion: "Northern America",
                    population: 38000000,
                    area: 9984670,
                    flags: .init(png: "url")
            ),
            Country(name: .init(common: "France",
                                official: "France"),
                    capital: ["Paris"],
                    continents: [],
                    region: "Europe",
                    subregion: "Western Europe",
                    population: 67000000,
                    area: 551695,
                    flags: .init(png: "url")
            )
        ]
        
        let useCase = MockGetAllCountriesSortedByNameUseCase(result: .success(mockCountries))
        let viewModel = CountryListViewModel(useCase)

        await viewModel.loadCountries()

        XCTAssertEqual(viewModel.countries.count, mockCountries.count)
        XCTAssertEqual(viewModel.countries.first?.name.common, "Canada")
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.showError)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testLoadCountries_Failure() async {
        let useCase = MockGetAllCountriesSortedByNameUseCase(result: .failure(NSError(domain: "TestError",
                                                                                      code: 1,
                                                                                      userInfo: [NSLocalizedDescriptionKey: "Failed to load"])))
        let viewModel = CountryListViewModel(useCase)
        await viewModel.loadCountries()

        XCTAssertTrue(viewModel.countries.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, "Failed to load")
        XCTAssertTrue(viewModel.showError)
        XCTAssertFalse(viewModel.isLoading)
    }
}
