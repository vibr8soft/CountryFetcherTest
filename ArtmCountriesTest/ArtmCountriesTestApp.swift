import SwiftUI
import SwiftData

@main
struct ArtmCountriesTestApp: App {
    init() {
        configureDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            CountryListView()
        }
    }

    private func configureDependencies() {
        let container = DependenciesContainer.shared

        container.register(type: CountryServiceProtocol.self,
                           factory: CountryService())
        
        container.register(
            type: IGetAllCountriesSortedByNameUseCase.self,
            factory: GetAllCountriesSortedByNameUseCase(countriesService: container.resolve())
        )
    }
}
