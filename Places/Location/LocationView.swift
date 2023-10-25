//
//  LocationView.swift
//  Places
//
//  Created by Dide van Berkel on 25/10/2023.
//

import SwiftUI

struct LocationView: View {

    @ObservedObject private var viewModel: LocationViewModel

    init(viewModel: LocationViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.locations, id: \.self) { location in
                    Text(location.name ?? "Unknown name")
                }
            }
            .navigationTitle("Locations")
        }
        .task {
            await viewModel.getLocations()
        }
    }
}

#Preview {
    LocationView(viewModel: LocationViewModel(service: LocationService()))
}
