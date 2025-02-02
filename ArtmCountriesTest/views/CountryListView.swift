import SwiftUI

struct CountryListView: View {
    @StateObject private var viewModel = CountryListViewModel(DependenciesContainer.shared.resolve())
    @State private var selectedCountry: Country?

    var body: some View {
        NavigationStack {
            if (viewModel.isLoading) {
                VStack {
                    Spacer()
                    Text("Loading...")
                        .font(.headline)
                    Spacer()
                }
            } else {
                List(viewModel.countries, id: \.name.common) { country in
                    Button {
                        selectedCountry = country
                    } label: {
                        VStack {
                            Spacer()
                            HStack {
                                if let flagUrl = URL(string: country.flags.png) {
                                    AsyncImage(url: flagUrl) { image in
                                        image.resizable()
                                    } placeholder: {
                                        Color.gray
                                    }
                                    .frame(width:50, height: 30)
                                    .cornerRadius(5.0)
                                }
                                Text(country.name.common)
                                    .font(.headline)
                            }
                            Spacer()
                        }
                    }
                }
                .navigationTitle("Pays")
                .navigationDestination(item: $selectedCountry) { country in
                    CountryDetailsView(country: country)
                }
            }
        }
        .task {
            await viewModel.loadCountries()
        }
        .alert("Erreur", isPresented: $viewModel.showError, presenting: viewModel.errorMessage) { _ in
                    Button("OK", role: .cancel) {}
                } message: { errorMessage in
                    Text(errorMessage)
                }
    }
}
