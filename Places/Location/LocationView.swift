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
        NavigationStack {
            locationList
                .navigationTitle(Strings.locations)
                .navigationBarItems(trailing: addButton)
                .sheet(isPresented: $showSearch, content: searchContent)
                .alert(isPresented: $viewModel.isError) {
                    alertContent
                }
        }
        .task {
            await viewModel.getLocations()
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
        .listStyle(.automatic)
    }

    var addButton: some View {
        Button(action: {
            showSearch.toggle()
        }) {
            Images.add
        }
    }

    func searchContent() -> some View {
        viewModel.presentSearch(for: $viewModel.locations)
    }

    var alertContent: Alert {
        Alert(
            title: Text(Strings.alertTitle),
            message: Text(Strings.alertDescription),
            dismissButton: .default(Text(Strings.ok))
        )
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
