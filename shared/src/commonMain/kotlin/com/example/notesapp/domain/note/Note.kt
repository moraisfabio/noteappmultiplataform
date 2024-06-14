package com.example.notesapp.domain.note

import com.example.notesapp.presentation.BabyBlueHex
import com.example.notesapp.presentation.LightGreenHex
import com.example.notesapp.presentation.RedOrangeHex
import com.example.notesapp.presentation.RedPinkHex
import com.example.notesapp.presentation.VioletHex
import kotlinx.datetime.LocalDateTime

data class Note(
    val id: Long?,
    val title: String,
    val content: String,
    val colorHex: Long,
    val created: LocalDateTime
) {
    companion object {
        private val colors = listOf(RedOrangeHex, RedPinkHex, LightGreenHex, BabyBlueHex, VioletHex)

        fun generateRandomColors() = colors.random()
    }
}
