//
//  ImageRepositoryProtocol.swift
//  DZ11
//
//  Created by Эмиль Шамшетдинов on 07.05.2025.
//
protocol ImageRepositoryProtocol {
    func fetchImages(urls: [String], completion: @escaping ([ImageEntity]) -> Void)
}
