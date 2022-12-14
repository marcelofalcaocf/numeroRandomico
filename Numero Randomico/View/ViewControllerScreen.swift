//
//  ViewControllerScreen.swift
//  Numero Randomico
//
//  Created by Marcelo Falcao Costa Filho on 20/11/22.
//

import UIKit

protocol ViewControllerScreenProtocol {
    func actionTryNumberButton()
    func actionResetButton()
}

class ViewControllerScreen: UIView {

    private var delegate: ViewControllerScreenProtocol?

    func delegate(delegate: ViewControllerScreenProtocol?) {
        self.delegate = delegate
    }
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 217/255, green: 168/255, blue: 33/255, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Bem vindo usuário, acerte o numero que o aplicativo pensou para você."
        return label
    }()
    
    lazy var explanationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 59/255, green: 34/255, blue: 12/255, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Você tem 3 chances para acertar!"
        return label
    }()
    
    lazy var numberTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.backgroundColor = UIColor(red: 199/255, green: 185/255, blue: 110/255, alpha: 1.0)
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.placeholder = "Digite o numero"
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var tryNumberButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tentar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.darkGray, for: .normal)
        button.backgroundColor = UIColor(red: 59/255, green: 34/255, blue: 12/255, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(self.tappedTryNumberButton), for: .touchUpInside)
        return button
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Resetar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 59/255, green: 34/255, blue: 12/255, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(self.tappedResetButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configBackGroundColor()
        configSuperView()
        setUPConstraints()
    }
    
    private func configBackGroundColor() {
        backgroundColor = .gray
    }
    
    private func configSuperView() {
        addSubview(welcomeLabel)
        addSubview(explanationLabel)
        addSubview(numberTextField)
        addSubview(tryNumberButton)
        addSubview(resetButton)
    }
    
    public func configTextFieldDelegate(delegate: UITextFieldDelegate) {
        self.numberTextField.delegate = delegate
    }
    
    public func validateTextFields() {
        let number: Int = Int(numberTextField.text ?? "0" ) ?? 0
        
        if number != 0 {
            configButtonEnabel(true)
        } else {
            configButtonEnabel(false)
        }
    }
    
    private func configButtonEnabel(_ enabel: Bool) {
        if enabel {
            tryNumberButton.setTitleColor(.white, for: .normal)
            tryNumberButton.isEnabled = true // permitido apertar o botao "isEnabled"
        } else {
            tryNumberButton.setTitleColor(.darkGray, for: .normal)
            tryNumberButton.isEnabled = false // nao permitido apertar o botao
        }
    }
    
    public func numberExists() -> Int {
        if let number = Int(numberTextField.text ?? "0") {
            return number
        }
        return 0
    }
    
    public func userWon() {
        explanationLabel.text = "Parabéns, você acertou!"
        tryNumberButton.isEnabled = false
        tryNumberButton.setTitleColor(.darkGray, for: .normal)
    }
    
    public func userErrForLess() {
        explanationLabel.text = "Você errou, aumente seu numero!"
    }
    
    public func userFailed() {
        explanationLabel.text = "Acabaram suas tentativas, comece de novo!"
        tryNumberButton.isEnabled = false
        tryNumberButton.setTitleColor(.darkGray, for: .normal)
    }
    
    public func userErrForMore() {
        explanationLabel.text = "Você errou, diminua seu numero!"
    }
    
    public func resetGame() {
        explanationLabel.text = "Você tem 3 chances para acertar!"
        numberTextField.text = ""
    }
    
    @objc private func tappedTryNumberButton() {
        delegate?.actionTryNumberButton()
        //viewController.validateInformation(number: numberTextField, explanation: explanationLabel, button: tryNumberButton)
    }
    
    @objc private func tappedResetButton() {
        delegate?.actionResetButton()
        //viewController.resetGame(number: numberTextField, explanation: explanationLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUPConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 70),
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            explanationLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            explanationLabel.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor, constant: 0),
            explanationLabel.trailingAnchor.constraint(equalTo: welcomeLabel.trailingAnchor, constant: 0),
            
            numberTextField.topAnchor.constraint(equalTo: explanationLabel.bottomAnchor, constant: 20),
            numberTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            numberTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            numberTextField.heightAnchor.constraint(equalToConstant: 45),
            
            tryNumberButton.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 20),
            tryNumberButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            tryNumberButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            tryNumberButton.heightAnchor.constraint(equalToConstant: 45),
            
            resetButton.topAnchor.constraint(equalTo: tryNumberButton.bottomAnchor, constant: 50),
            resetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            resetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            resetButton.heightAnchor.constraint(equalToConstant: 45),
            
        ])
    }
}
