//
//  LoadingProtocol.swift
//  Places
//
//  Created by Dide van Berkel on 29/10/2023.
//

import Foundation

protocol LoadingProtocol: ObservableObject {
    var state: LoadingState { get }
    func load() async
}
