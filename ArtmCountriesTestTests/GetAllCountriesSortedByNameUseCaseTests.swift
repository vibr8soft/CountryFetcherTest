import XCTest
@testable import ArtmCountriesTest

class GetAllCountriesSortedByNameUseCaseTests: XCTestCase {

    var mockService: MockCountryService!
    var useCase: GetAllCountriesSortedByNameUseCase!

    override func setUp() {
        super.setUp()
        mockService = MockCountryService()
        useCase = GetAllCountriesSortedByNameUseCase(countriesService: mockService)
    }

    override func tearDown() {
        mockService = nil
        useCase = nil
        super.tearDown()
    }

    func test_getAllCountriesSortedByName_returnsSortedCountries() async {
        let country1 = Country(name: .init(common: "Canada", official: "Canada"),
                               capital: ["Ottawa"],
                               continents: [],
                               region: "Americas",
                               subregion: "Northern America",
                               population: 38000000,
                               area: 9984670,
                               flags: .init(png: "")
        )
        let country2 = Country(name: .init(common: "France", official: "French Republic"),
                               capital: ["Paris"],
                               continents: [],
                               region: "Europe",
                               subregion: "Western Europe",
                               population: 67000000,
                               area: 55169,
                               flags: .init(png: "")
        )
        let country3 = Country(name: .init(common: "Brazil", official: "Brazil"),
                               capital: ["Brasília"],
                               continents: [],
                               region: "Americas",
                               subregion: "South America",
                               population: 212000000,
                               area: 8515767,
                               flags: .init(png: ""))

        mockService.result = .success([country1, country2, country3])

        let result = await useCase.getAllCountriesSortedByName()

        switch result {
        case .success(let sortedCountries):
            let sortedNames = sortedCountries.map { $0.name.common }
            XCTAssertEqual(sortedNames, ["Brazil", "Canada", "France"], "La liste de pays n'est pas triée correctement par nom")
        case .failure:
            XCTFail("Succes était attendu mais echec")
        }
    }

    func test_getAllCountriesSortedByName_handlesError() async {
        mockService.result = .failure(NSError(domain: "TestError", code: 1, userInfo: nil))

        let result = await useCase.getAllCountriesSortedByName()

        switch result {
        case .success:
            XCTFail("Échec de l'exécution du test. Aucune erreur n'a été renvoyée.")
        case .failure(let error):
            XCTAssertNotNil(error, "Erreur attendue non trouvée.")
        }
    }
}
