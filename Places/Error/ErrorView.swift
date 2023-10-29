//
//  ErrorView.swift
//  Places
//
//  Created by Dide van Berkel on 29/10/2023.
//

import SwiftUI

struct ErrorView: View {

    var body: some View {
        VStack {
            Text(Strings.alertTitle)
            Text(Strings.alertDescription)
        }
    }
}

#Preview {
    ErrorView()
}
