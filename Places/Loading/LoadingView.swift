//
//  LoadingView.swift
//  Places
//
//  Created by Dide van Berkel on 29/10/2023.
//

import Foundation
import SwiftUI

struct LoadingView<Source: LoadingProtocol, Content: View>: View {
    @ObservedObject var source: Source
    var content: () -> Content

    init(
        source: Source,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.source = source
        self.content = content
    }

    var body: some View {
        switch source.state {
        case .idle:
            EmptyView()
        case .loading:
            ProgressView()
        case .error:
            ErrorView()
        case .success:
            content()
        }
    }
}
