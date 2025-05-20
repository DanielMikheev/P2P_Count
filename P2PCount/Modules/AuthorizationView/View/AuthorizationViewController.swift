//
//  AuthorizationViewController.swift
//  P2PCount
//
//  Created by Dany on 03.05.2025.
//

import UIKit

protocol AuthorizationViewControllerProtocol: AnyObject {
    var emailTextField: UITextField { get set }
    var passwordTextField: UITextField { get set }
}
final class AuthorizationViewController: UIViewController, AuthorizationViewControllerProtocol {
    
    var presenter: AuthorizationViewPresenterProtocol!
    
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
    
    private lazy var authorizationLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Authorization"
        $0.font = UIFont(name: "K2D-ExtraLight", size: 24)
        $0.textColor = .text
        $0.numberOfLines = 1
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
     lazy var emailTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedPlaceholder = NSAttributedString(string: AuthorizeModel.email, attributes: [.foregroundColor: UIColor(red: 53/255, green: 74/255, blue: 128/255, alpha: 1)])
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
        $0.attributedPlaceholder = NSAttributedString(string: AuthorizeModel.password, attributes: [.foregroundColor: UIColor(red: 53/255, green: 74/255, blue: 128/255, alpha: 1)])
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
    
    private lazy var authorizeButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitleColor(.text, for: .normal)
        $0.setAttributedTitle(NSAttributedString(string: "Enter", attributes: [.font : UIFont(name: "K2D-Medium", size: 17) ?? ""]), for: .normal)
        $0.backgroundColor = .accent
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        return $0
    }(UIButton(primaryAction: authorizeAction))
    
    private lazy var dontHaveAccBtn: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setAttributedTitle(NSAttributedString(string: AuthorizeModel.dontHaveAcc, attributes: [.font : UIFont(name: "K2D-Medium", size: 14) ?? ""]), for: .normal)
        $0.backgroundColor = .clear
        $0.setTitleColor(UIColor(named: "accent"), for: .normal)
        $0.clipsToBounds = true
        return $0
    }(UIButton(primaryAction: dontHaveAccAction))
    
    lazy var dontHaveAccAction: UIAction = UIAction{[weak self] _ in
        guard let self = self else { return }
        self.presenter.donthaveAcc()
    }

    lazy var authorizeAction: UIAction = UIAction { [weak self]_ in
        guard let self = self else { return }
        guard let email = self.emailTextField.text else { return }
        guard let password = self.passwordTextField.text else { return }
        self.presenter.authUser(userInfo: UserLoginData(email: email, password: password))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .main
        view.addSubviews(highFigure, titleLabel, authorizationLabel, emailTextField, passwordTextField, authorizeButton, dontHaveAccBtn)
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            authorizationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 130),
            authorizationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            authorizationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            authorizationLabel.heightAnchor.constraint(equalToConstant: 30),
            
            emailTextField.topAnchor.constraint(equalTo: authorizationLabel.bottomAnchor, constant: 96),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 35),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            authorizeButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 136),
            authorizeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorizeButton.widthAnchor.constraint(equalToConstant: 124),
            authorizeButton.heightAnchor.constraint(equalToConstant: 43),
            
            dontHaveAccBtn.topAnchor.constraint(equalTo: authorizeButton.bottomAnchor, constant: 18),
            dontHaveAccBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dontHaveAccBtn.widthAnchor.constraint(equalToConstant: 120),
            dontHaveAccBtn.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
