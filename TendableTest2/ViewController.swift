//
//  ViewController.swift
//  TendableTest
//
//  Created by devang bhavsar on 01/08/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var loginViewModel = LoginViewModel()
    @IBOutlet weak var btnSubmit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnSubmitClicked(_ sender: Any) {
        if txtEmail.text == "" && txtPassword.text == "" {
            print("\(EmaildIdCheck.emailorPasswordincorrect)")
        }
        else if loginViewModel.setupEmailValidation(emailId: txtEmail.text!) {
            self.setupAPIRequest()
       } else {
           print("\(EmaildIdCheck.emaildNotValied)")
       }
       
    }
    
    @IBAction func btnSignUpClicked(_ sender: Any) {
        let objNext = UIStoryboard(name: kMainStoryBoard, bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
        self.present(objNext!, animated: true, completion: nil)
        
    }
    
    func  setupAPIRequest() {
        let url = kbaseURL + kloginURL
        let dicdata = ["email":txtEmail.text!,
                       "password":txtPassword.text!
        ] as [String : Any]
        DispatchQueue.global(qos: .userInteractive).sync {
            APIRequestURL().postRequest(serviceName: url, httpMethod:"POST", andParams: dicdata) { success in
                DispatchQueue.main.async {
                    setAlertWithCustomAction(viewController: self, message: "Login Success", ok: { isSuccess in
                        //Next View Controller
                        userDefault.set(self.txtEmail.text!, forKey: kEmail)
                        userDefault.set(self.txtPassword.text!, forKey: kPassword)
                        userDefault.synchronize()
                            let objNext = UIStoryboard(name: kMainStoryBoard, bundle: nil).instantiateViewController(withIdentifier: "StartSessionViewController") as? StartSessionViewController
                            self.navigationController?.pushViewController(objNext!, animated: true)
                        self.txtEmail.text = ""
                        self.txtPassword.text = ""
                    }, isCancel: false) { failed in
                    }
                }
                
            } andFailureBlock: { error in
                DispatchQueue.main.async {
                    Alert().showAlert(message: error, viewController: self)
                }
                
               // print("error data = \(error)")
            }

        }
    }


}

