//
//  PokemonCell.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Lilia Yudina on 12/12/19.
//  Copyright © 2019 Lilia Yudina. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {

    @IBOutlet weak var pokemonImage: UIImageView!
    
    func configureCell(for pokemon: Pokemon) {
        ImageClient.fetchImage(for: pokemon.imageUrl) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("error:\(error)")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.pokemonImage.image = image
                }
            }
        }
    }

}
