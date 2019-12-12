//
//  AppError.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Lilia Yudina on 12/11/19.
//  Copyright © 2019 Lilia Yudina. All rights reserved.
//

import Foundation

enum AppError: Error {
    case badURL(String)
    case noResponse
    case networkClientError(Error)
    case noData
    case decodingError(Error)
    case badStatusCode(Int)
    case badMimeType(String)
}
