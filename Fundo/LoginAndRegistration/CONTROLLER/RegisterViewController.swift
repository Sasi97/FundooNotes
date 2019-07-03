//
//  RegisterViewController.swift
//  Fundo
//
//  Created by BridgeLabz Solutions LLP  on 6/3/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit



class RegisterViewController: UIViewController {
    
    @IBOutlet weak var genderTxtFld: UITextField!
    @IBOutlet weak var pnhTxtFld: UITextField!
    @IBOutlet weak var nameTxtFld: UITextField!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var pswdTxtFld: UITextField!
    @IBOutlet weak var conformPswdTxt: UITextField!
    var userHelper = UserDataHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func navigate()  {
        guard let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as? LoginViewController else { return  }
        self.present(loginVC, animated: true)
    }
    
   
    @IBAction func didClickRegister(_ sender: Any) {
        
        guard let name = nameTxtFld.text,let emailId = emailTxtFld.text,let password = pswdTxtFld.text,let gender = genderTxtFld.text,let phnNumber = pnhTxtFld.text,let conformPassword = conformPswdTxt.text else { return }
        let userDetails = User.init(name: name, emailId: emailId, password: password, gender: gender, phNumber: phnNumber)
        if name.isEmpty || emailId.isEmpty || password.isEmpty || conformPassword.isEmpty || phnNumber.isEmpty || gender.isEmpty{
            AlertService.displayAlert(userMsg: "*All Fields are Required")
        }
        else{
            if !Validation.isEmailValid(email: emailId){
               AlertService.displayAlert(userMsg: "Enter Valid Email")
            }else if !Validation.isPasswordValid(password : password){
               AlertService.displayAlert(userMsg: "Enter Valid PassWord")
            }else if password != conformPassword{
               AlertService.displayAlert(userMsg: "PassWord Doesn't matches")
            }else if !Validation.isPhnNumValid(number: phnNumber){
               AlertService.displayAlert(userMsg: "Enter Valid Phone NUmber")
            }else{
                
                userHelper.saveUserDetails(user: userDetails)
                navigate()
            }
        }
    }
    
}
