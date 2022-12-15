//
//  List.swift
//  BookOutlet
//
//  Created by Luis Fernando Salas Gave on 14/12/22.
//

import Foundation

struct List: Decodable {
    let title: String
    let author: String
    let image: String
    let description: String
    let price: Double
    let review: String
}
