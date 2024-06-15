//
//  NoteListScreen.swift
//  iosApp
//
//  Created by QAnnouns on 13/06/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import shared

struct NoteListScreen: View {
    
    private var noteDataSource: NoteDataSource
    @StateObject var viewModel = NoteListViewModel(noteDataSource: nil)
    
    @State private var isNoteSelected = false
    @State private var selectedNoteId: Int64? = nil
    
    init(noteDataSource: NoteDataSource) {
        self.noteDataSource = noteDataSource
    }
    
    var body: some View {
        VStack {
            ZStack {
                NavigationLink("Detail Screen") {
                    NoteDetailScreen(noteDataSource: self.noteDataSource, noteId: selectedNoteId)
                }.hidden()
                HideableSearchTextField<NoteDetailScreen>(
                    onSearchToggled: {viewModel.toggleIsSearchActive()},
                    destinationProvider: {
                        if isNoteSelected {
                            NoteDetailScreen(noteDataSource: noteDataSource, noteId: selectedNoteId)
                        } else {
                            NoteDetailScreen(noteDataSource: noteDataSource)
                        }
                    },
                    isSearchActive: viewModel.isSearchActive,
                    isNoteSelected: isNoteSelected,
                    searchText: $viewModel.searchtext
                )
                .frame(maxWidth: .infinity, minHeight: 40)
                .padding()
                
                if !viewModel.isSearchActive {
                    Text("All Notes")
                        .font(.title2)
                }
            }
            List {
                ForEach(viewModel.filteredNotes, id: \.self.id){ note in
                    Button(action: {
                        self.isNoteSelected.toggle()
                        selectedNoteId = note.id?.int64Value
                    }) {
                        NoteItem(
                            note: note,
                            onDeleteClick: {
                                viewModel.deleteNotesById(id: note.id?.int64Value)
                            }
                        )
                    }
                }
            }
            .onAppear {
                viewModel.loadNotes()
            }
            .listStyle(.plain)
            .listRowSeparator(.hidden)
        }
        .onAppear {
            viewModel.setNoteDataSource(noteDataSource: noteDataSource)
        }
    }
}
