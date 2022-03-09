//
//  CinebaixModel.swift
//  cinebaix
//
//  Created by Alex on 30/10/21.
//

import Foundation

// MARK: - MovieElement
struct Movie: Decodable, Hashable, Identifiable {
    var id = UUID()
    let title, duration, classification, rating, img: String
    let schedule: [Schedule]

    private enum CodingKeys : String, CodingKey { case title, duration, classification, rating, img, schedule }

}

// MARK: - Schedule
struct Schedule: Decodable, Hashable {
    let day: String
    let rooms: [Room]
}

// MARK: - Room
struct Room: Decodable, Hashable {
    let room, time: String
}
