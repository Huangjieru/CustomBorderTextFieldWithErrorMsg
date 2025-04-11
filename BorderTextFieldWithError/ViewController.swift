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
        
        name.setTitleInfo(titleText: "姓名")
//        name.placeholder = "請輸入姓名"
        name.rightViewMode = .always
        name.rightView = eyeButton
        
        birthday.setTitleInfo(titleText: "西元生日")
        birthday.placeholder = "YYYY/MM/DD"
        birthday.clearButtonMode = .whileEditing
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

