import Foundation
class CountryListViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published var errorMessage: String? {
        didSet {
            showError = errorMessage != nil
        }
    }
    @Published var showError: Bool = false
    @Published var isLoading: Bool = false

    private let getAllCountriesSortedByNameUseCase: IGetAllCountriesSortedByNameUseCase

    init(_ getAllCountriesUseCase: IGetAllCountriesSortedByNameUseCase) {
        getAllCountriesSortedByNameUseCase = getAllCountriesUseCase
    }

    @MainActor
    func loadCountries() async {
        isLoading = true

        let countriesResult = await getAllCountriesSortedByNameUseCase.getAllCountriesSortedByName()

        switch countriesResult {
        case .success(let countries):
            self.countries = countries
            errorMessage = nil
        case .failure(let error):
            self.countries = []
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
