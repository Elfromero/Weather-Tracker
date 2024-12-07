//
//  NoLocationSelectedView.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/7/24.
//

import SwiftUI

struct NoLocationSelectedView: View {
    var body: some View {
        VStack {
            Text("No City Selected")
                .font(Font.custom("Poppins-SemiBold", size: 30))
            Text("Please Search For A City")
                .font(Font.custom("Poppins-SemiBold", size: 15))
        }
        .foregroundStyle(Color.primaryBlack)
    }
}

#Preview {
    NoLocationSelectedView()
}
