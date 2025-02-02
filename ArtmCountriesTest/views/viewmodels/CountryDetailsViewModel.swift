import Foundation
class CountryDetailsViewModel: ObservableObject {
    @Published var flagUrl: URL?
    @Published var countryName: String = ""
    @Published var capital: String = ""
    @Published var continent: String = ""
    @Published var populations: String = ""

    func load(country: Country) {
        countryName = country.name.common
        flagUrl = URL(string: country.flags.png)
        capital = country.capital?.first ?? ""
        continent = country.continents?.first ?? ""
        populations = String(country.population)
    }
}
