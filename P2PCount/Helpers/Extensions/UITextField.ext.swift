//
//  UITextField.swift
//  P2PCount
//
//  Created by Dany on 07.05.2025.
//

import UIKit


extension OneCurrencyViewController: UITextFieldDelegate {

    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.font = UIFont(name: "K2D-Bold", size: 18)
//    }

//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if string.isEmpty { return true }
//        let maxLength = 7
//        let allowedCharacters = CharacterSet.decimalDigits
//        let characterSet = CharacterSet(charactersIn: string)
//        guard allowedCharacters.isSuperset(of: characterSet) else {
//                    return false
//                }
//        let currentText = textField.text ?? ""
//        let futureText = (currentText as NSString).replacingCharacters(in: range, with: string)
//        if (futureText.count == 1 && futureText == "0") || range.location >= maxLength {
//                return false
//            }
//            return true
//        }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    
}

extension MultiCurrencyViewController: UITextFieldDelegate {
    
}
