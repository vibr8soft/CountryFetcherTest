import SwiftUI

struct CountryDetailsView: View {
    @StateObject private var viewModel = CountryDetailsViewModel()
    private let country: Country

    init(country: Country) {
        self.country = country
    }

    var body: some View {
        VStack {
            if let flagUrl = viewModel.flagUrl {
                AsyncImage(url: flagUrl) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width:100.0, height: 60.0)
                .cornerRadius(5.0)
            }
            Text(viewModel.countryName)
                .font(.headline)
            Text(viewModel.capital)
                .font(.subheadline)
            HStack {
                Text("Continent: ")
                    .font(.caption)
                    .bold()
                Text(viewModel.continent)
                    .font(.caption)
            }
            HStack {
                Text("Populations: ")
                    .font(.caption)
                    .bold()
                Text(viewModel.populations)
                    .font(.caption)
            }
            Spacer()
        }
        .task {
            viewModel.load(country: country)
        }
    }
}
