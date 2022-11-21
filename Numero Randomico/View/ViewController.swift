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
        guard let number = Int(viewControllerScreen.numberTextField.text ?? "0") else { return }
        
        if number == numberRandom {
            viewControllerScreen.explanationLabel.text = "Parabéns, você acertou!"
            attempts = []
            viewControllerScreen.tryNumberButton.isEnabled = false
            viewControllerScreen.tryNumberButton.setTitleColor(.darkGray, for: .normal)
        } else if number < numberRandom && attempts.count < 3 {
            attempts.append(number)
            viewControllerScreen.explanationLabel.text = "Você errou, aumente seu numero!"
            if attempts.count == 3 {
                viewControllerScreen.explanationLabel.text = "Acabaram suas tentativas, comece de novo!"
                viewControllerScreen.tryNumberButton.isEnabled = false
                viewControllerScreen.tryNumberButton.setTitleColor(.darkGray, for: .normal)
            }
        } else if number > numberRandom && attempts.count < 3 {
            attempts.append(number)
            viewControllerScreen.explanationLabel.text = "Você errou, diminua seu numero!"
            if attempts.count == 3 {
                viewControllerScreen.explanationLabel.text = "Acabaram suas tentativas, comece de novo!"
                viewControllerScreen.tryNumberButton.isEnabled = false
                viewControllerScreen.tryNumberButton.setTitleColor(.darkGray, for: .normal)
            }
        } else {
            viewControllerScreen.explanationLabel.text = "Acabaram suas tentativas, comece de novo!"
            viewControllerScreen.tryNumberButton.isEnabled = false
        }
        
        print(attempts)
    }
    
    func resetGame() {
        numberRandom = Int.random(in: 1...10)
        attempts = []
        viewControllerScreen.explanationLabel.text = "Você tem 3 chances para acertar!"
        viewControllerScreen.numberTextField.text = ""
    }
    
    public func validateTextFields() {
        let number: Int = Int(viewControllerScreen.numberTextField.text ?? "0" ) ?? 0
        
        if number != 0 {
            self.configButtonEnabel(true)
        } else {
            self.configButtonEnabel(false)
        }
    }
    
    private func configButtonEnabel(_ enabel: Bool) {
        if enabel {
            viewControllerScreen.tryNumberButton.setTitleColor(.white, for: .normal)
            viewControllerScreen.tryNumberButton.isEnabled = true // permitido apertar o botao "isEnabled"
        } else {
            viewControllerScreen.tryNumberButton.setTitleColor(.darkGray, for: .normal)
            viewControllerScreen.tryNumberButton.isEnabled = false // nao permitido apertar o botao
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        validateTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension ViewController: ViewControllerScreenProtocol {
    func actionResetButton() {
        resetGame()
    }
    
    func actionTryNumberButton() {
        validateInformation()
    }
}
