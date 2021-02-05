//
//  ViewController.swift
//  DripReports
//
//  Created by 嘉山正太郎 on 2020/10/16.
//

import UIKit
import RealmSwift

class ReportListViewController: UIViewController ,
                                UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var listTableView: UITableView!
    
    
    @IBOutlet weak var reportButton: UIButton!
    
    
    private var reports:Results<RealmReport>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportButton.layer.cornerRadius = 25.0
        listTableView.dataSource = self
        listTableView.delegate = self
        let realm = try! Realm()
        reports = realm.objects(RealmReport.self)
    }
    // 画面を開くたびにリストを更新する
    override func viewWillAppear(_ animated: Bool) {
        let realm = try! Realm()
        reports = realm.objects(RealmReport.self)
        // reloadDate()は、tableviewに対してデータが新しくなったから更新しろの意
        listTableView.reloadData()
    }
    //Table Viewのセルの数を指定
    func tableView(_ table: UITableView,
                  numberOfRowsInSection section: Int) -> Int {
        // countが0
        return reports?.count ?? 0
   }
    
    func numberOfSections(in tableView: UITableView) -> Int {
    return 1
    }

//    func getTimeString(report:RealmReport) -> String {
//    return report.dripMinutes.toString() + "min" + report.dripSeconds.toString() + "s"
//    }
    
    
    @IBAction func createReportButton(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditReportTableViewController") as! EditReportTableViewController
        secondViewController.isEditMode = false
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    //各セルの要素を設定する
    func tableView(_ table: UITableView,
              cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // reportCell の ID で UITableViewCell のインスタンスを生成
        let cell = table.dequeueReusableCell(withIdentifier: "reportCell",for: indexPath) as! ReportTableViewCell
        if reports != nil {
            let report = reports![indexPath.row]
            cell.roasterLabel.text = report.roasterName
            cell.countryLabel.text = report.country
            cell.beansProcessLabel.text = report.beansProcess
            cell.createdAtLabel.text = report.createdAt.toDisplayString()
            cell.beansAmountLabel.text = "beans: " + String(report.beansAmount) + "g"
        }
        return cell
    }

    //タップをしたら遷移する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditReportTableViewController") as! EditReportTableViewController
        secondViewController.selectedReportId = reports![indexPath.row].id
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            let realm = try! Realm()
            try! realm.write {
                realm.delete(reports![indexPath.row])
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    

}
