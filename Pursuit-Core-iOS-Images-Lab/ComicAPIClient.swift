//
//  ComicAPIClient.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Lilia Yudina on 12/11/19.
//  Copyright © 2019 Lilia Yudina. All rights reserved.
//

import Foundation

struct ComicAPIClient {
    static func getComic(recent: Bool, number: Int, completion: @escaping (Result<ComicData, AppError>) -> ()) {
        
        var endpointURLString = String()
        
        if !recent {
            endpointURLString = "https://xkcd.com/\(number.description)/info.0.json"
        } else {
            endpointURLString = "https://xkcd.com/info.0.json"
        }
        
        NetworkHelper.shared.performDataTask(with: endpointURLString) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searches = try JSONDecoder().decode(ComicData.self, from: data)
                    let countries = searches
                    completion(.success(countries))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
