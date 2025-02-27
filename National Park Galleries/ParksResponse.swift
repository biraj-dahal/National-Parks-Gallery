//
//  ParksResponse.swift
//  National Park Galleries
//
//  Created by Biraj Dahal on 2/27/25.
//

import SwiftUI

struct ParksResponse: Codable {
    let data: [Park]
}

struct Park: Codable, Identifiable {
    let id: String
    let fullName: String
    let description: String
    let latitude: String
    let longitude: String
    let images: [ParkImage]
    let name: String
}

struct ParkImage: Codable {
    let title: String
    let caption: String
    let url: String
}
