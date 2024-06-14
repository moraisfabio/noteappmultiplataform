package com.example.notesapp.data.local

import app.cash.sqldelight.db.SqlDriver
import com.example.notesapp.database.NoteDatabase

expect class DatabaseDriverFactory {
    fun createDriver(): SqlDriver
}

fun createDatabase(driverFactory: DatabaseDriverFactory): NoteDatabase {
    val driver = driverFactory.createDriver()
    val database = NoteDatabase(driver)
    return database
}