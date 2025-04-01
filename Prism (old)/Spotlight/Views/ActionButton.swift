//
//  Untitled.swift
//  Spotlight
//
//  Created by Maliyah Howell on 3/20/25.
//

import SwiftUI

struct ActionButton: View {
    let action: () -> Void
    let icon: String
    let color: Color

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding()
                .background(color)
                .foregroundColor(.white)
                .clipShape(Circle()) // ✅ Fixed typo
                .shadow(radius: 5)
        }
    }
}



