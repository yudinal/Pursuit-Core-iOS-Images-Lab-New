//
//  ViewController.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Lilia Yudina on 12/11/19.
//  Copyright © 2019 Lilia Yudina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var stepperControl: UIStepper!
    @IBOutlet weak var textField: UITextField!
    
    var recent = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        configureStepper()
        loadComic()
    }
    
    func loadComic() {
        ComicAPIClient.getComic(recent: recent, number: Int(stepperControl.value)) { (result) in
            switch result {
            case .failure(let error):
                print("appError: \(error)")
            case .success(let data):
                ImageClient.fetchImage(for: data.img) { [weak self] (result) in
                    switch result {
                    case .failure(let error):
                        print("error: \(error)")
                    case .success(let image):
                        DispatchQueue.main.async {
                            self?.comicImage.image = image
                        }
                    }
                }
            }
        }
        
    }
    
    func configureStepper() {
        stepperControl.minimumValue = 1.0
        stepperControl.maximumValue = 2240.0
        stepperControl.stepValue = 1.0
        
        stepperControl.value = 23.0
    }
    
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        recent = false
        stepperControl.value = sender.value
        loadComic()
    }
    
    
    
    @IBAction func mostRecentBottonPressed(_ sender: UIButton) {
        recent = true
        loadComic()
        
    }
    
    @IBAction func randomButtonPressed(_ sender: UIButton) {
        recent = false
        stepperControl.value = Double(Int.random(in: 1...2240))
        loadComic()
    }
    
    
}
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = textField.text else {
            return false
        }
        let textAsDouble = Double(text) ?? 0
        stepperControl.value = textAsDouble
        loadComic()
        textField.resignFirstResponder()
        return true
    }
}
