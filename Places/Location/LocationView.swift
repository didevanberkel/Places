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
    @State private var locations = [Location]()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.locations, id: \.self) { location in
                    Text(location.name ?? "Unknown name")
                }
            }
            .navigationTitle("Locations")
            .navigationBarItems(trailing: addButton)
            .onChange(of: locations) {
                if let firstLocation = locations.first, locations.count == 1 {
                    viewModel.locations.append(firstLocation)
                }
            }
            .sheet(isPresented: $showModal) {
                SearchLocationView(viewModel: SearchLocationViewModel(localSearchCompleter: MKLocalSearchCompleter()), locations: $locations)
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
            Text("Show Modal")
        }
    }
}

#Preview {
    LocationView(viewModel: LocationViewModel(service: LocationService()))
}
