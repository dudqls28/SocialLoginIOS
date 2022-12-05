//
//  EnterEmailViewController.swift
//  SocialLoginIOS
//
//  Created by hwict on 2022/12/05.
//

import UIKit

class EnterEmailViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = 30
        nextButton.isEnabled = false

        emailTextField.delegate = self
        passwordTextField.delegate = self
        //첫번쨰커서가 이메일 텍스트필드로
        emailTextField.becomeFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Navi Bar 보이기
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
    }
}

extension EnterEmailViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
