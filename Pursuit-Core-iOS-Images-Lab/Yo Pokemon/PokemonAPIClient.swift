//
//  PokeminAPIClient.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Lilia Yudina on 12/12/19.
//  Copyright © 2019 Lilia Yudina. All rights reserved.
//

import Foundation

struct PokemonAPIClient {
    static func getPokemon(completion: @escaping (Result<[Pokemon],AppError>) -> ()) {
        let endpointURLString = "https://api.pokemontcg.io/v1/cards"
        
        NetworkHelper.shared.performDataTask(with: endpointURLString) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searches = try JSONDecoder().decode(Cards.self, from: data)
                    let pokemons = searches.cards
                    completion(.success(pokemons))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
