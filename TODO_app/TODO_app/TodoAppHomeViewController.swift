//
//  TodoAppHomeViewController.swift
//  TODO_app
//
//  Created by Chetan Patel on 2022-11-27.
//

import Foundation
import UIKit

class TodoAppHomeViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, TodoData{
    
    
    let simpleTableIdentifier = "SimpleTableIdentifier"
    
    @IBOutlet weak var todoTaskTableView: UITableView!
    
    var tableData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fileURL = self.dataFileURL()

        if (FileManager.default.fileExists(atPath: fileURL.path!)){
            if let array = NSArray(contentsOf: fileURL as URL) as? [String]{
                for i in 0..<array.count{
                    tableData[i] = array[i]
                }
            }
        }
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(notification:)),
            name: UIScene.willDeactivateNotification, object: nil)
    }
    func dataFileURL() -> NSURL{
        let urls = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)
        var url:NSURL?
        url = URL(fileURLWithPath: "") as NSURL?
        do{
            url = urls.first?.appendingPathComponent("data.plist") as NSURL?
        }
        catch{
           print("Error is \(error)")
        }
        
        return url!
    }
    @objc func applicationWillResignActive(notification: NSNotification){
        print("in appication will resign active")
        
        let fileURL = self.dataFileURL()
        let array: NSMutableArray = []
        for line in self.tableData{
            array.add(line)
        }
       
        array.write(to: fileURL as URL, atomically: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.tableData[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
          //todos.remove(at: (indexPath as NSIndexPath).row)
            todoTaskTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
      }
    @IBAction func addTaskButton(_ sender: Any) {
        self.performSegue( withIdentifier: "AddSegue", sender: self)
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject){
//        if segue.identifier == "AddSegue" {
//            let vc = segue.destination as! TodoAppAddTask
//            vc.delegate = self
//        }
//    }
    func getData(data: String) {
        print(data)
        self.tableData.append(data)
        self.todoTaskTableView.reloadData()
    }
    
}
