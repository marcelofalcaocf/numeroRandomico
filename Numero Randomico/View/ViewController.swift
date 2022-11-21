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
    }
    
    func validateInformation(number: UITextField, explanation: UILabel, button: UIButton) {
        guard let number = Int(number.text ?? "0") else { return }
        
        if number == numberRandom {
            explanation.text = "Parabéns, você acertou!"
            attempts = []
            button.isEnabled = false
            button.setTitleColor(.darkGray, for: .normal)
        } else if number < numberRandom && attempts.count < 3 {
            attempts.append(number)
            explanation.text = "Você errou, aumente seu numero!"
            if attempts.count == 3 {
                explanation.text = "Acabaram suas tentativas, comece de novo!"
                button.isEnabled = false
                button.setTitleColor(.darkGray, for: .normal)
            }
        } else if number > numberRandom && attempts.count < 3 {
            attempts.append(number)
            explanation.text = "Você errou, diminua seu numero!"
            if attempts.count == 3 {
                explanation.text = "Acabaram suas tentativas, comece de novo!"
                button.isEnabled = false
                button.setTitleColor(.darkGray, for: .normal)
            }
        } else {
            explanation.text = "Acabaram suas tentativas, comece de novo!"
            button.isEnabled = false
        }
        
        print(attempts)
    }
    
    func resetGame(number: UITextField, explanation: UILabel) {
        numberRandom = Int.random(in: 1...10)
        attempts = []
        explanation.text = "Você tem 3 chances para acertar!"
        number.text = ""
    }
    
    public func validateTextFields(number: UITextField) {
        let number: Int = Int(number.text ?? "0" ) ?? 0
        
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
        validateTextFields(number: textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

