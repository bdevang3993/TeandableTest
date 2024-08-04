//
//  QuationAndAnsViewController.swift
//  TendableTest2
//
//  Created by devang bhavsar on 02/08/24.
//

import UIKit

class QuationAndAnsViewController: UIViewController {

    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var tblDisplayAns: UITableView!
    var totalScore:Double = 0.0
    var arrQuestion = [Questions]()
    var arransChoice = [AnswerChoices]()
    var objQuastionAndAnsViewModel = QuastionAndAnsViewModel()
    var index:Int = 0
    var selectedAns:AnswerChoices?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        objQuastionAndAnsViewModel.viewController = self
        objQuastionAndAnsViewModel.getquestionFromDB()
        if objQuastionAndAnsViewModel.arrQuestion.count > 0 {
            objQuastionAndAnsViewModel.getAnsFromDB(questionId: objQuastionAndAnsViewModel.arrQuestion[0].id!)
        }
        self.tblDisplayAns.delegate = self
        self.tblDisplayAns.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setUpQuestion()
    }
    
//    func setUpQuestion() {
//        self.lblQuestion.text = arrQuestion[index].name
//        if let ans = arrQuestion[index].answerChoices {
//            self.arransChoice = ans
//        }
//        self.tblDisplayAns.reloadData()
//    }
    
    func setUpQuestion() {
        self.lblQuestion.text = objQuastionAndAnsViewModel.arrQuestion[index].name
        objQuastionAndAnsViewModel.getAnsFromDB(questionId: objQuastionAndAnsViewModel.arrQuestion[index].id!)
        self.tblDisplayAns.reloadData()
    }
    
    @IBAction func btnPreviousClicked(_ sender: Any) {
        index = index - 1
        if objQuastionAndAnsViewModel.arrQuestion.count > index && index >= 0 {//arrQuestion
            self.setUpQuestion()
        } else {
            index = index + 1
            Alert().showAlert(message: "This is your first question", viewController: self)
        }
    }
    
    @IBAction func btnNextClicked(_ sender: Any) {
        index = index + 1
        if objQuastionAndAnsViewModel.arrQuestion.count > index {//arrQuestion
            self.setUpQuestion()
        } else {
            index = index - 1
            Alert().showAlert(message: "This is your last question", viewController: self)
        }
    }
    @IBAction func btnSubmitClicked(_ sender: Any) {
//        arrQuestion[index].selectedAnswerChoiceId = ("\(selectedAns?.id)")
//        for i in 0...arransChoice.count - 1 {
//            if arransChoice[i].isSelected {
//                if let score = arransChoice[i].score {
//                    totalScore = totalScore + score
//                }
//            }
//        }
        
        
        print(totalScore)
        
        setAlertWithCustomAction(viewController: self, message: "TotalScore = \(totalScore)", ok: { isTrue in
            self.navigationController?.popViewController(animated: true)
        }, isCancel: false) { isfalse in
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
extension QuationAndAnsViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return arransChoice.count
        return objQuastionAndAnsViewModel.arrChoice.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblDisplayAns.dequeueReusableCell(withIdentifier: "QuestionAndAnsTableViewCell") as? QuestionAndAnsTableViewCell
        //let name = arransChoice[indexPath.row].name
        //let isSelected = arransChoice[indexPath.row].isSelected
        let isSelected = objQuastionAndAnsViewModel.arrChoice[indexPath.row].selected
        if isSelected == 1 {
            cell?.contentView.backgroundColor = .yellow
        } else {
            cell?.contentView.backgroundColor = .clear
        }
        let name = objQuastionAndAnsViewModel.arrChoice[indexPath.row].title
        cell?.lblAns.text = name
        cell?.selectionStyle = .none
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if objQuastionAndAnsViewModel.arrChoice[indexPath.row].selected == 1 {
            //arransChoice[indexPath.row].isSelected = false
            objQuastionAndAnsViewModel.arrChoice[indexPath.row].selected = 0
            objQuastionAndAnsViewModel.updateSelectedAnsInDB(id: objQuastionAndAnsViewModel.arrChoice[indexPath.row].id!, selected: 0)
            totalScore = totalScore - objQuastionAndAnsViewModel.arrChoice[indexPath.row].score!
        } else {
            //arransChoice[indexPath.row].isSelected = true
            objQuastionAndAnsViewModel.arrChoice[indexPath.row].selected = 1
            objQuastionAndAnsViewModel.updateSelectedAnsInDB(id: objQuastionAndAnsViewModel.arrChoice[indexPath.row].id!, selected: 1)
            totalScore = totalScore + objQuastionAndAnsViewModel.arrChoice[indexPath.row].score!
        }
        self.tblDisplayAns.reloadData()
    }
    
}
