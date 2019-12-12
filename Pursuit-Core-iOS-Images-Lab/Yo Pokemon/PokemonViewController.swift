//
//  PokemonViewController.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Lilia Yudina on 12/12/19.
//  Copyright © 2019 Lilia Yudina. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var pokemons = [Pokemon]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadPokemons()
    }
    
    func loadPokemons() {
        PokemonAPIClient.getPokemon { (result) in
            switch result {
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let pokemons):
                self.pokemons = pokemons
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pokemonVC = segue.destination as? DetailPokemonController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("could not find that pokemon")
        }
        pokemonVC.pokemon = pokemons[indexPath.row]
    }

}
extension PokemonViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonCell else {
           fatalError("Couldn't dequeue a PokemonCell")
        }
        let pokemon = pokemons[indexPath.row]
        cell.configureCell(for: pokemon)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
