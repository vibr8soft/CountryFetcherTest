struct GetAllCountriesSortedByNameUseCase: IGetAllCountriesSortedByNameUseCase {
    private let countriesService: CountryServiceProtocol

    init (countriesService: CountryServiceProtocol) {
        self.countriesService = countriesService
    }

    func getAllCountriesSortedByName() async -> Result<[Country], Error> {
        do {
            return try await .success(
                countriesService
                .fetchAllCountryList()
                .sorted { $0.name.common < $1.name.common }
            )
        } catch {
            return .failure(error)
        }
    }
}
