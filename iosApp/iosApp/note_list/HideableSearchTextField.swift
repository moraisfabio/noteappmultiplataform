//
//  HideableSearchTextField.swift
//  iosApp
//
//  Created by QAnnouns on 13/06/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct HideableSearchTextField<Destination: View>: View {
    var onSearchToggled: () -> Void
    var destinationProvider: () -> Destination
    var isSearchActive: Bool
    var isNoteSelected: Bool
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            TextField("Search...", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .opacity(isSearchActive ? 1 : 0)
            if isSearchActive {
                Spacer()
            }
            Button(action: onSearchToggled){
                Image(systemName: isSearchActive ? "xmark" : "magnifyingglass")
                    .foregroundColor(.black)
            }
            NavigationLink(destination: destinationProvider) {
                if isNoteSelected {
                    Image(systemName: "pencil")
                        .foregroundColor(.black)
                } else {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                }
            }
        }
    }
}
