//
//  SearchLocationModel.swift
//  Places
//
//  Created by Dide van Berkel on 25/10/2023.
//

import MapKit

struct SearchResult: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
}
