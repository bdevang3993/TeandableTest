//
//  CategoryListViewController.swift
//  TendableTest2
//
//  Created by devang bhavsar on 02/08/24.
//

import UIKit

class CategoryListViewController: UIViewController {
    var arrCategory = [Categories]()
    @IBOutlet weak var tblDisplayData: UITableView!
    @IBOutlet weak var btnSubmit: UIButton!
    var objCategoryListViewModel = CategoryListViewModel()
    var arrCategoryListDB = [CategoryListDB]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tblDisplayData.dataSource = self
        self.tblDisplayData.delegate = self
        objCategoryListViewModel.viewController = self
        objCategoryListViewModel.arrCategory = arrCategory
        objCategoryListViewModel.getInfo()
        if objCategoryListViewModel.nextIndex <= 0 {
            Alert().showAlert(message: "No data found in database", viewController: self)
            objCategoryListViewModel.dataSaveInDataBase()
        } else {
            objCategoryListViewModel.getAllCategoryList { array in
                self.arrCategoryListDB = array
                DispatchQueue.main.async {
                    self.tblDisplayData.reloadData()
                }
            }
        }
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmitClicked(_ sender: Any) {
        let objNext = UIStoryboard(name: kMainStoryBoard, bundle: nil).instantiateViewController(withIdentifier: "EndSectionViewController") as? EndSectionViewController
        self.navigationController?.pushViewController(objNext!, animated:true)
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
extension CategoryListViewController:UITableViewDelegate,UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.arrCategory.count
        return arrCategoryListDB.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblDisplayData.dequeueReusableCell(withIdentifier: "CategoryListTableViewCell") as? CategoryListTableViewCell
        //let name = arrCategory[indexPath.row].name
        let name = arrCategoryListDB[indexPath.row].name
        cell?.lblCategory.text = name
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryesquestions = arrCategory[indexPath.row].questions
        if categoryesquestions!.count > 0 {
            self.moveToNext(arrQuestion: categoryesquestions!)
        }
    }
    
    func moveToNext(arrQuestion:[Questions]) {
        let objNext = UIStoryboard(name: kMainStoryBoard, bundle: nil).instantiateViewController(withIdentifier: "QuationAndAnsViewController") as? QuationAndAnsViewController
        objNext?.arrQuestion = arrQuestion
        self.navigationController?.pushViewController(objNext!, animated: true)
    }
}
