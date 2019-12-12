//
//  DetailPokemonController.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Lilia Yudina on 12/12/19.
//  Copyright © 2019 Lilia Yudina. All rights reserved.
//

import UIKit

class DetailPokemonController: UIViewController {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var weaknessLabel: UILabel!
    @IBOutlet weak var setLabel: UILabel!
    
    var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    func updateUI() {
        guard let chosenPokemon = pokemon else {
            fatalError("country is nil, verify prepare(for segue: )")
        }
        nameLabel.text = chosenPokemon.name
        typeLabel.text = chosenPokemon.supertype
        setLabel.text = chosenPokemon.set
        weaknessLabel.text = chosenPokemon.weaknesses?.first?.type
        
        ImageClient.fetchImage(for: chosenPokemon.imageUrlHiRes) { [weak self](result) in
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
