//
//  RegisterViewController.swift
//  TendableTest
//
//  Created by devang bhavsar on 01/08/24.
//

import UIKit

class RegisterViewController: UIViewController {
    var loginViewModel = LoginViewModel()
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet var txtEmail: UITextField!
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
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    func  setupAPIRequest() {
        let url = kbaseURL + kregisterURL
        let dicdata = ["email":txtEmail.text!,
                       "password":txtPassword.text!
        ] as [String : Any]
        DispatchQueue.global(qos: .userInteractive).sync {
            APIRequestURL().postRequest(serviceName: url, httpMethod:"POST", andParams: dicdata) { success in
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
            } andFailureBlock: { error in
                DispatchQueue.main.async {
                    Alert().showAlert(message: error, viewController: self)
                }
                
            }

        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
