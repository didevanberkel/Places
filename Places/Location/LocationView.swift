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
            List {
                ForEach(viewModel.locations, id: \.self) { location in
                    Text(location.name ?? Strings.unknownName)
                }
            }
            .navigationTitle(Strings.locations)
            .navigationBarItems(trailing: addButton)
            .sheet(isPresented: $showModal) {
                SearchLocationView(viewModel: SearchLocationViewModel(localSearchCompleter: MKLocalSearchCompleter()), locations: $viewModel.locations)
            }
        }
        .task {
            await viewModel.getLocations()
        }
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
    LocationView(viewModel: LocationViewModel(service: LocationService()))
}
