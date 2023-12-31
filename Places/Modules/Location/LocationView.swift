//
//  LocationView.swift
//  Places
//
//  Created by Dide van Berkel on 25/10/2023.
//

import SwiftUI
import MapKit

struct LocationView: View {

    @ObservedObject var viewModel: LocationViewModel

    @State private var showSearch = false

    var body: some View {
        LoadingView(source: viewModel) {
            NavigationStack {
                locationList
                    .navigationTitle(Strings.locations)
                    .navigationBarItems(trailing: addButton)
                    .sheet(isPresented: $showSearch, content: searchContent)
            }
        }
        .task {
            await viewModel.load()
        }
    }
}

private extension LocationView {
    var locationList: some View {
        List(viewModel.locations) { location in
            Link(
                location.title ?? Strings.unknownTitle,
                destination: URL.wikipedia(location: location)
            )
        }
        .foregroundStyle(Colors.placesGreen)
        .listStyle(.automatic)
    }

    var addButton: some View {
        Button(action: {
            showSearch.toggle()
        }) {
            Images.add
                .renderingMode(.template)
                .foregroundColor(Colors.placesGreen)
        }
    }

    func searchContent() -> some View {
        viewModel.presentSearch(for: $viewModel.locations)
    }
}

#Preview {
    LocationView(
        viewModel: LocationViewModel(
            router: LocationRouter(),
            service: LocationService(apiRequest: APIRequest())
        )
    )
}
