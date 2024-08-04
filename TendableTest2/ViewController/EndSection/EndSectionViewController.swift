//
//  EndSectionViewController.swift
//  TendableTest2
//
//  Created by devang bhavsar on 02/08/24.
//

import UIKit

class EndSectionViewController: UIViewController {

    @IBOutlet weak var btnSubmitClicked: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnSubmitClicked(_ sender: Any) {
        self.setupAPIRequest()
        
    }
    
    func  setupAPIRequest() {
        let url = kbaseURL + kEndSection
        let dicData = [String:Any]()//kStratSection
        DispatchQueue.global(qos: .userInteractive).sync {
            APIRequestURL().postRequest(serviceName: url, httpMethod:"POST", andParams: dicData) { success in
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
