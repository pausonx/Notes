//
//  Note.swift
//  Notes Watch App
//
//  Created by Paulina Wyskiel on 20/03/2023.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
