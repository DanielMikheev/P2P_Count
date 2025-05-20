//
//  ViewController.swift
//  P2PCount
//
//  Created by Dany on 29.04.2025.
//

import UIKit

protocol RegistrationViewControllerProtocol: AnyObject {
    var nameTextField: UITextField {get set}
    var emailTextField: UITextField {get set}
    var passwordTextField: UITextField {get set}
}

protocol RegistrationViewControllerDelegate: AnyObject {
    func registNewUser()
}

final class RegistrationViewController: UIViewController, RegistrationViewControllerProtocol, RegistrationViewControllerDelegate {

    var presenter: RegistrationViewPresenterProtocol?
    
    private lazy var highFigure: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.frame.size = CGSize(width: view.frame.width, height: 136)
        $0.frame.origin = CGPoint(x: 0, y: 0)
        $0.backgroundColor = .lightMain
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 30
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return $0
    }(UIView())
    
    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "P2P Count"
        $0.font = UIFont(name: "K2D-Medium", size: 20)
        $0.textColor = .text
        $0.numberOfLines = 1
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var registrationLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Registration"
        $0.font = UIFont(name: "K2D-ExtraLight", size: 24)
        $0.textColor = .text
        $0.numberOfLines = 1
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
     lazy var nameTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedPlaceholder = NSAttributedString(string: RegistTextModel.name, attributes: [.foregroundColor: UIColor(red: 53/255, green: 74/255, blue: 128/255, alpha: 1)])
        $0.font = UIFont(name: "K2D-ExtraLight", size: 18)
        $0.backgroundColor = .lightMain
        $0.textColor = .text
        $0.leftViewMode = .always
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 19))
        $0.layer.cornerRadius = 30
        return $0
    }(UITextField())
    
     lazy var emailTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedPlaceholder = NSAttributedString(string: RegistTextModel.email, attributes: [.foregroundColor: UIColor(red: 53/255, green: 74/255, blue: 128/255, alpha: 1)])
        $0.font = UIFont(name: "K2D-ExtraLight", size: 18)
        $0.backgroundColor = .lightMain
        $0.autocapitalizationType = .none
        $0.textColor = .text
        $0.leftViewMode = .always
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 19))
        $0.layer.cornerRadius = 30
        return $0
    }(UITextField())
    
     lazy var passwordTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedPlaceholder = NSAttributedString(string: RegistTextModel.password, attributes: [.foregroundColor: UIColor(red: 53/255, green: 74/255, blue: 128/255, alpha: 1)])
        $0.font = UIFont(name: "K2D-ExtraLight", size: 18)
        $0.backgroundColor = .lightMain
        $0.autocapitalizationType = .none
        $0.isSecureTextEntry = true
        $0.textColor = .text
        $0.leftViewMode = .always
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 19))
        $0.layer.cornerRadius = 30
        return $0
    }(UITextField())
    
    private lazy var registButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitleColor(.text, for: .normal)
        $0.setAttributedTitle(NSAttributedString(string: "Regist", attributes: [.font : UIFont(name: "K2D-Medium", size: 17) ?? ""]), for: .normal)
        $0.backgroundColor = .accent
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
//        $0.addTarget(self, action: #selector(showCustomAlert), for: .touchUpInside)
        return $0
    }(UIButton(primaryAction: registAction))
    
    private lazy var haveAccBtn: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setAttributedTitle(NSAttributedString(string: RegistTextModel.haveAcc, attributes: [.font : UIFont(name: "K2D-Medium", size: 14) ?? ""]), for: .normal)
        $0.backgroundColor = .clear
        $0.setTitleColor(UIColor(named: "accent"), for: .normal)
        $0.clipsToBounds = true
        return $0
    }(UIButton(primaryAction: haveAccAction))
    
    lazy var haveAccAction: UIAction = UIAction { [weak self]_ in
        guard let self = self else { return }
        self.presenter?.haveAcc()
    }
    
    lazy var registAction: UIAction = UIAction{ [weak self] _ in
        let customAlert = CustomAlertViewController()
        customAlert.delegate = self
        customAlert.modalPresentationStyle = .overCurrentContext
        customAlert.modalTransitionStyle = .crossDissolve
        self?.present(customAlert, animated: true)
    }
    
    func registNewUser() {
        guard let name = self.nameTextField.text else { return }
        guard let email = self.emailTextField.text else { return }
        guard let password = self.passwordTextField.text else { return }
        self.presenter?.registNewUser(userData: UserLoginData(name: name, email: email, password: password))
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .main
        view.addSubviews(highFigure, titleLabel, registrationLabel, nameTextField, emailTextField, passwordTextField, registButton, haveAccBtn)
        setupConstraints()
    }
//    
//    
//    @objc
//    func showCustomAlert() {
//        let customAlert = CustomAlertViewController()
//        customAlert.modalPresentationStyle = .overCurrentContext
//        customAlert.modalTransitionStyle = .crossDissolve
//        present(customAlert, animated: true)
//    }

    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            registrationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 130),
            registrationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            registrationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            registrationLabel.heightAnchor.constraint(equalToConstant: 30),
            
            nameTextField.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: 56),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 35),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 35),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            registButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 91),
            registButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registButton.widthAnchor.constraint(equalToConstant: 124),
            registButton.heightAnchor.constraint(equalToConstant: 43),
            
            haveAccBtn.topAnchor.constraint(equalTo: registButton.bottomAnchor, constant: 18),
            haveAccBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            haveAccBtn.widthAnchor.constraint(equalToConstant: 120),
            haveAccBtn.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

}

