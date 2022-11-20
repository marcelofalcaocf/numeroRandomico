//
//  ViewController.swift
//  Numero Randomico
//
//  Created by Marcelo Falcao Costa Filho on 20/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var viewControllerScreen: ViewControllerScreen = .init()
    var numberRandom = Int.random(in: 1...99)
    var attempts: [Int] = []
    
    override func loadView() {
        self.view = self.viewControllerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerScreen.configTextFieldDelegate(delegate: self)
        viewControllerScreen.delegate(delegate: self)
        print(numberRandom)
        
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
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewControllerScreen.validateTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension ViewController: ViewControllerScreenProtocol {
    func actionResetButton() {
        numberRandom = Int.random(in: 1...99)
        attempts = []
        viewControllerScreen.explanationLabel.text = "Você tem 3 chances para acertar!"
        print(numberRandom)
    }
    
    func actionTryNumberButton() {
        validateInformation()

    }
    
    
}


//Criar um aplicativo onde gere um número randômico de 0 à 10 e armazene essa informação em uma variável. O usuário deve informar um número e o sistema apresenta se ele acertou ou se o número correto é maior ou menor.
//
//Caso o usuário acerte, deve permitir que ele resete o jogo e comece novamente com um novo número sorteado.
//
//Caso erre, deve permitir uma nova tentativa. O usuário deve ter no máximo 3 tentativas, caso contrário ele perde.

//- trabalhar com randomico
//- Condições logicas
//- Enums
