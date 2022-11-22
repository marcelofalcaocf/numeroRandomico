//
//  ViewController.swift
//  Numero Randomico
//
//  Created by Marcelo Falcao Costa Filho on 20/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var viewControllerScreen: ViewControllerScreen = .init()
    var numberRandom = Int.random(in: 1...10)
    var attempts: [Int] = []
    
    override func loadView() {
        self.view = self.viewControllerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerScreen.configTextFieldDelegate(delegate: self)
        viewControllerScreen.delegate(delegate: self)
    }
    
    func validateInformation() {
        let number = viewControllerScreen.numberExists()
        
        if  number == numberRandom {
            viewControllerScreen.userWon()
            attempts = []
        } else if number < numberRandom && attempts.count < 3 {
            attempts.append(number)
            viewControllerScreen.userErrForLess()
            if attempts.count == 3 {
                viewControllerScreen.userFailed()
            }
        } else if number > numberRandom && attempts.count < 3 {
            attempts.append(number)
            viewControllerScreen.userErrForMore()
            if attempts.count == 3 {
                viewControllerScreen.userFailed()
            }
        } else {
            viewControllerScreen.userFailed()
        }
        print(attempts)
    }
    
    func resetGame() {
        numberRandom = Int.random(in: 1...10)
        attempts = []
        viewControllerScreen.resetGame()
    }
}

extension ViewController: ViewControllerScreenProtocol {
    func actionTryNumberButton() {
        validateInformation()
    }
    
    func actionResetButton() {
        resetGame()
    }
    
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewControllerScreen.validateTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

