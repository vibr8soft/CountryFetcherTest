import Foundation

struct CountryService: CountryServiceProtocol {
    private let allCountriesEndpoint = "https://restcountries.com/v3.1/all"

    func fetchAllCountryList() async throws -> [Country] {
        guard let url = URL(string: allCountriesEndpoint) else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode([Country].self, from: data)
    }
}
