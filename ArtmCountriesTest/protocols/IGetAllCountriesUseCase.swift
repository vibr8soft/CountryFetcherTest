protocol IGetAllCountriesSortedByNameUseCase {
    func getAllCountriesSortedByName() async -> Result<[Country], Error>
}
