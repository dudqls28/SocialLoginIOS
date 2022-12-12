//
//  LoginViewController.swift
//  SocialLoginIOS
//
//  Created by hwict on 2022/12/05.
//

import UIKit
import GoogleSignIn
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [emailLoginButton,googleLoginButton,appleLoginButton].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Navigation Bar 숨기기
        navigationController?.navigationBar.isHidden = true
        
        //Google Sign In
        //GIDSignIn.sharedInstance.presentingViewController = self
    }
    
    @IBAction func googleLoginButtonTapped(_ sender: GIDSignInButton) {
        //Firebase 인증
        debugPrint("Click Google")
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            guard error == nil else { return }
            
            //구글인증 토큰 받기 -> 사용자 정보 토큰 생성 -> 파이어베이스 인증 등록
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            //사용자 정보 등록
            Auth.auth().signIn(with: credential) { _,_ in
                //사용자 등록후 처리
                debugPrint("TEST")
                self.showMainViewController()
            }
        }
    }
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        UIApplication.shared.windows.first?.rootViewController?.show(mainViewController, sender: nil)
    }
    @IBAction func appleLoginButtonTapped(_ sender: UIButton) {
        //Firebase 인증
        debugPrint("Click Apple")
    }
}
