//
//  Product.swift
//  Emile HW8
//
//  Created by Эмиль Шамшетдинов on 16.04.2025.
//
struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
    
    struct Rating: Codable {
        let rate: Double
        let count: Int
    }
}

