//
//  CustomVerifyAlert.swift
//  P2PCount
//
//  Created by Dany on 07.05.2025.
//

import UIKit

final class CustomAlertViewController: UIViewController {
    
    var delegate: RegistrationViewControllerDelegate?
    
    private lazy var containerView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .content
        $0.alpha = 0.9
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
        return $0
    }(UIView())
    
    private lazy var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedText = NSAttributedString(string: "Подтвердите\nверификацию", attributes: [.foregroundColor : UIColor(named: "accent") ?? .accent, .font : UIFont(name: "K2D-Bold", size: 15) ?? .systemFont(ofSize: 15, weight: .bold)])
        $0.textAlignment = .center
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    private lazy var messageLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Нажмите ОК, чтобы получить\nна почту письмо верификации"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var okButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("OK", for: .normal)
        $0.titleLabel?.font = UIFont(name: "K2D-Medium", size: 17)
        $0.backgroundColor = .clear
        $0.setTitleColor(.accent, for: .normal)
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(okDismissAlert), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    private lazy var cancelButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Cancel", for: .normal)
        $0.titleLabel?.font = UIFont(name: "K2D-Medium", size: 17)
        $0.backgroundColor = .clear
        $0.setTitleColor(.red, for: .normal)
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(cancelDismissAlert), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    @objc
    func okDismissAlert() {
        dismiss(animated: true)
        self.delegate?.registNewUser()
    }
    
    @objc
    func cancelDismissAlert(){
        dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        view.addSubview(containerView)

        containerView.addSubview(titleLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(okButton)
        containerView.addSubview(cancelButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {

        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 200),
            containerView.heightAnchor.constraint(equalToConstant: 160),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 19),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            messageLabel.heightAnchor.constraint(equalToConstant: 36),
            
            okButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 9),
            okButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 6),
            okButton.widthAnchor.constraint(equalToConstant: 92),
            cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -6),
            
            cancelButton.topAnchor.constraint(equalTo: okButton.topAnchor, constant: 0),
            cancelButton.leadingAnchor.constraint(equalTo: okButton.trailingAnchor, constant: 4),
            cancelButton.widthAnchor.constraint(equalToConstant: 92),
            cancelButton.bottomAnchor.constraint(equalTo: okButton.bottomAnchor, constant: 0),
            
            
        ])
    }

}
