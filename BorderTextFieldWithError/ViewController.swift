//
//  ViewController.swift
//  BorderTextFieldWithError
//
//  Created by JRU on 2025/4/10.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var name: BorderTextFieldWithErrorMsg!
    @IBOutlet weak var birthday: BorderTextFieldWithErrorMsg!
    
    @IBOutlet weak var eyeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.setTitleInfo(titleText: "")
//        name.placeholder = "請輸入姓名" //或在Attributes inspector輸入placeholder
        name.rightView = eyeButton
        name.delegate = self
        name.setBorderColor(borderColor: UIColor.clear, inputBorderColor: UIColor.systemMint)
        name.tintColor = UIColor.systemMint
        name.textColor = UIColor.systemGray
        
        birthday.setTitleInfo(titleText: "西元生日")
        birthday.placeholder = "YYYY/MM/DD"
        birthday.clearButtonMode = .whileEditing
        birthday.delegate = self
        
        setTap()
    }
    
    @IBAction func showError(_ sender: UIButton) {
        name.setErrorInfo(errorText: "打錯囉！！")
        birthday.setErrorInfo(errorText: "打錯囉！！")
    }
    
    @IBAction func clearError(_ sender: UIButton) {
        name.setErrorInfo(errorText: nil)
        birthday.setErrorInfo(errorText: nil)
    }
    
    @IBAction func showWords(_ sender: UIButton) {
        name.isSecureTextEntry.toggle()
    }
    
    private func setTap() {
        let tapDismissKeyBoard = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        self.view.addGestureRecognizer(tapDismissKeyBoard)
    }
    
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case name:
            name.setErrorInfo(errorText: nil)
        case birthday:
            birthday.setErrorInfo(errorText: nil)
        default:
            return true
        }
        return true
    }
}
