//
//  EditReportViewController.swift
//  DripReports
//
//  Created by 嘉山正太郎 on 2020/10/17.
//

import UIKit
import RealmSwift

class EditReportTableViewController: UITableViewController {

    @IBOutlet weak var roasterNameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var beansProcessTextField: UITextField!
    @IBOutlet weak var beansAmountTextField: UITextField!
    @IBOutlet weak var waterAmountTextField: UITextField!
    @IBOutlet weak var dripMinutesTextField: UITextField!
    @IBOutlet weak var dripSecondsTextField: UITextField!
    @IBOutlet weak var flavorTextView: UITextView!
    @IBOutlet weak var commentTextView: UITextView!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    
    var selectedReportId = 0
    var isEditMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
//        プライマリーキーの値をとってきて　ビューに反映させる
//        ?がついたらnil ~オプショナル型　!はアンラップ、多用厳禁　慎重に考えろ
        if isEditMode {
            doneButton.title = "完了"
            title = "編集"
            let object = realm.objects(RealmReport.self).filter("id = \(selectedReportId)").first!
            beansProcessTextField.text = object.beansProcess
            beansAmountTextField.text = "\(object.beansAmount)"
            waterAmountTextField.text = "\(object.waterAmount)"
            dripSecondsTextField.text = "\(object.dripSeconds)"
            dripMinutesTextField.text = "\(object.dripMinutes)"
            countryTextField.text = object.country
            commentTextView.text = object.comment
            flavorTextView.text = object.flavorText
            roasterNameTextField.text = object.roasterName
        }else{
            doneButton.title = "保存"
            title = "新規作成"
        }
        
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        if isEditMode {
            edit()
        }else{
            save()
        }
        // 前画面に戻す処理　共通だからifの外に書く
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func save() {
        let realm = try! Realm()
        let savedata = RealmReport()
        savedata.setNewId()
        // savedata.beansAmount = Double(beansAmountTextField.text!) ?? 0
        // 上記をifで書いたら下記になる
        if Double(beansAmountTextField.text!) == nil {
            savedata.beansAmount = 0
        }else{
            savedata.beansAmount = Double(beansAmountTextField.text!)!
        }
        savedata.beansProcess = beansProcessTextField.text!
        savedata.waterAmount = Int(waterAmountTextField.text!) ?? 0
        savedata.dripMinutes = Int(dripMinutesTextField.text!) ?? 0
        savedata.dripSeconds = Int(dripSecondsTextField.text!) ?? 0
        savedata.country = countryTextField.text!
        savedata.comment = commentTextView.text!
        savedata.flavorText = flavorTextView.text!
        savedata.roasterName = roasterNameTextField.text!
        try! realm.write {
            realm.add(savedata, update: .modified)
        }

    }
    
    private func edit(){
//        realm()はできたてほやほやのコピー品
        let realm = try! Realm()
        let savedata = RealmReport()
        savedata.id = selectedReportId
        savedata.beansAmount = Double(beansAmountTextField.text!)!
        savedata.beansProcess = beansProcessTextField.text!
        savedata.waterAmount = Int(waterAmountTextField.text!)!
        savedata.dripMinutes = Int(dripMinutesTextField.text!)!
        savedata.dripSeconds = Int(dripSecondsTextField.text!)!
        savedata.country = countryTextField.text!
        savedata.comment = commentTextView.text!
        savedata.flavorText = flavorTextView.text!
        savedata.roasterName = roasterNameTextField.text!
        try! realm.write {
            realm.add(savedata, update: .modified)
        }
    }
        
}

    
