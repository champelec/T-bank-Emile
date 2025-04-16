//
//  ImageLoaderViewProtocol.swift
//  Emile DZ8
//
//  Created by Эмиль Шамшетдинов on 16.04.2025.
//
import UIKit

protocol ImageLoaderViewProtocol: AnyObject {
    func reloadData()
    func reloadRow(at index: Int)
    func showError(message: String)
    func showLoadingIndicator(_ show: Bool)
    func updateProgress(_ progress: Float)
}
