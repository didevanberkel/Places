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

    @State private var showModal = false

    var body: some View {
        NavigationStack {
            locationList
                .navigationTitle(Strings.locations)
                .navigationBarItems(trailing: addButton)
                .sheet(isPresented: $showModal) {
                    viewModel.search(for: $viewModel.locations)
                }
        }
        .task {
            await viewModel.getLocations()
        }
    }
}

extension LocationView {
    private var locationList: some View {
        List {
            ForEach(viewModel.locations, id: \.self) { location in
                Link(
                    location.title ?? Strings.unknownTitle,
                    destination: URL.wikipedia(location: location)
                )
            }
        }
        .listStyle(.automatic)
    }

    private var addButton: some View {
        Button(action: {
            self.showModal.toggle()
        }) {
            Images.add
        }
    }
}

#Preview {
    LocationView(
        viewModel: LocationViewModel(
            router: LocationRouter(),
            service: LocationService()
        )
    )
}
