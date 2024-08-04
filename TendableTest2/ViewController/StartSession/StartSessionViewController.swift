//
//  StartSessionViewController.swift
//  TendableTest2
//
//  Created by devang bhavsar on 02/08/24.
//

import UIKit

class StartSessionViewController: UIViewController {
    var arrCategories = [Categories]()
    @IBOutlet weak var btnSubmitClicked: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupAPIRequest()
        
    }
    
    @IBAction func btnSubmitClicked(_ sender: Any) {
        DispatchQueue.main.async {
            let objNext = UIStoryboard(name: kMainStoryBoard, bundle: nil).instantiateViewController(identifier: "CategoryListViewController") as? CategoryListViewController
            objNext?.arrCategory = self.arrCategories
            self.navigationController?.pushViewController(objNext!, animated: true)
        }
        
    }
    @IBAction func btnbackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func  setupAPIRequest() {
        let url = kbaseURL + kStartSection
        DispatchQueue.global(qos: .userInteractive).sync {
            APIRequestURL().getRequest(serviceName:url) { (ss:StratSection) in
                kStratSection = ss
                self.arrCategories = (ss.inspection?.survey?.categories)!
                print("Data = \(self.arrCategories.count)")
            } andFailureBlock: { error in
                Alert().showAlert(message: error, viewController: self)
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
