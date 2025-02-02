import XCTest
@testable import ArtmCountriesTest

class CountryDetailsViewModelTests: XCTestCase {
    
    var viewModel: CountryDetailsViewModel!

    override func setUp() {
        super.setUp()
        viewModel = CountryDetailsViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func test_loadCountry_setsCorrectProperties() {
        // Given
        let testCountry = Country(
            name: Country.Name(common: "Canada", official: "Canada"),
            capital: ["Ottawa"],
            continents: ["North America", "Other"],
            region: "Americas",
            subregion: "Northern America",
            population: 38000000,
            area: 9984670,
            flags: Country.Flags(png: "https://example.com/canada.png")
        )

        // When
        viewModel.load(country: testCountry)

        // Then
        XCTAssertEqual(viewModel.countryName, "Canada")
        XCTAssertEqual(viewModel.capital, "Ottawa")
        XCTAssertEqual(viewModel.continent, "North America")
        XCTAssertEqual(viewModel.populations, "38000000")
        XCTAssertEqual(viewModel.flagUrl?.absoluteString, "https://example.com/canada.png")
    }

    func test_loadCountry_handlesNilValues() {
        // Given
        let testCountry = Country(
            name: Country.Name(common: "Unknown", official: "Unknown"),
            capital: nil,
            continents: nil,
            region: "Unknown",
            subregion: "Unknown",
            population: 0,
            area: nil,
            flags: Country.Flags(png: "")
        )

        // When
        viewModel.load(country: testCountry)

        // Then
        XCTAssertEqual(viewModel.capital, "")
        XCTAssertEqual(viewModel.continent, "")
        XCTAssertEqual(viewModel.flagUrl, nil)
    }
}
