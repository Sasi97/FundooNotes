//
//  LoginViewController.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/3/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit
import GoogleSignIn
class LoginViewController: UIViewController,GIDSignInDelegate,GIDSignInUIDelegate {
   
    @IBOutlet weak var googleSignIn:GIDSignInButton!
    
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var pswdTxtFld: UITextField!
    var userHelper = UserDataHelper()
    var noteHelper = NoteDataHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
//        GIDSignIn.sharedInstance().uiDelegate = self
//        GIDSignIn.sharedInstance()?.delegate  = self

       // userHelper.deleteAllUsers()
        //noteHelper.deleteAllNotes()
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            print(error.localizedDescription)
            return
        }
        print("\(user?.profile?.email)")
        NotificationCenter.default.post(name: NSNotification.Name("GoogleUser"), object: nil, userInfo: ["User":user])
    }
   
    @IBAction func didClickLogin(_ sender: Any) {
        guard let emailId = emailTxtFld.text,let password = pswdTxtFld.text else { return  }
        if emailTxtFld.text!.isEmpty || pswdTxtFld.text!.isEmpty {
            AlertService.displayAlert(userMsg: "*All Fileds are Required")
        }
        else{
            if Validation.isEmailValid(email: emailId) && Validation.isPasswordValid(password: password){
                let result = userHelper.isUserExist(userMail: emailId, userPassword: password )
                if result {
                    guard let dashBoardVC = UIStoryboard(name: "DashBoard", bundle: nil).instantiateViewController(withIdentifier: "dashBoardVC") as? ContainerVC else {return }
                    self.present(dashBoardVC, animated: true, completion: nil)
                }else{
                   AlertService.displayAlert(userMsg: "Email or Password is Incorrect ")
//                    let alert = UIAlertController(title: "***", message: "msg", preferredStyle: .alert)
//                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//                    alert.addAction(okAction)
//                    self.present(alert, animated: true, completion: nil)
               }
           }
       }
        UIView.animate(withDuration:0.2){
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func didClickSignIn(_ sender: Any) {
        guard let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "registerVC") as? RegisterViewController else { return  }
        self.present(registerVC, animated: true)
    }
   
    @IBAction func googleSignin(_ sender: GIDSignInButton) {
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance().signIn()
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToDash(notification: )), name: NSNotification.Name("GoogleUser"), object: nil)
      

    }
    @objc func navigateToDash(notification: NSNotification){
        
        let user = notification.userInfo!["User"]
        if user != nil{
            guard let dashBoardVC = UIStoryboard(name: "DashBoard", bundle: nil).instantiateViewController(withIdentifier: "dashBoardVC") as? ContainerVC else {return }
            self.present(dashBoardVC, animated: true, completion: nil)
        }
    }
}
