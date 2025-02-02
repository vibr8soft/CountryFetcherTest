protocol CountryServiceProtocol {
    func fetchAllCountryList() async throws -> [Country]
}
