//
//  NoteListViewModel.swift
//  iosApp
//
//  Created by QAnnouns on 13/06/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import shared

extension NoteListScreen {
    @MainActor class NoteListViewModel: ObservableObject {
        private var noteDataSource: NoteDataSource? = nil
        private var searchNotes = SearchNotes()
        
        private var notes = [Note]()
        @Published private(set) var filteredNotes = [Note]()
        @Published var searchtext = "" {
            didSet {
                self.filteredNotes = searchNotes.execute(notes: self.notes, query: searchtext)
            }
        }
        @Published private(set) var isSearchActive = false
        
        init(noteDataSource: NoteDataSource? = nil) {
            self.noteDataSource = noteDataSource
        }
        
        func loadNotes() {
            noteDataSource?.getAllNotes(completionHandler: {notes, error in
                self.notes = notes ?? []
                self.filteredNotes = self.notes
            })
        }
        
        func deleteNotesById(id: Int64?) {
            if id != nil {
                noteDataSource?.deleteNoteById(id: id!, completionHandler: { error in
                    self.loadNotes()
                })
            }
        }
        
        func toggleIsSearchActive(){
            isSearchActive = !isSearchActive
            if !isSearchActive {
                searchtext = ""
            }
        }
        
        func setNoteDataSource(noteDataSource: NoteDataSource){
            self.noteDataSource = noteDataSource
        }
    }
}
