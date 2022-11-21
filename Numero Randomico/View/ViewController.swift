//
//  ViewController.swift
//  Numero Randomico
//
//  Created by Marcelo Falcao Costa Filho on 20/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var viewControllerScreen: ViewControllerScreen = .init()
    
    override func loadView() {
        self.view = self.viewControllerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerScreen.configTextFieldDelegate(delegate: self)
        viewControllerScreen.delegate(delegate: self)
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
        viewControllerScreen.resetGame()
    }
    
    func actionTryNumberButton() {
        viewControllerScreen.validateInformation()

    }
}
