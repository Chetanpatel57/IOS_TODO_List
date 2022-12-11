//
//  TodoAppAddTask.swift
//  TODO_app
//
//  Created by Chetan Patel on 2022-11-27.
//

import Foundation
import UIKit

class TodoAppAddTask : UIViewController{
    
    var delegate: TodoData? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet weak var todoTaskText: UITextField!
    
    @IBAction func doneButtonpressed(_ sender: Any) {
//        if (self.todoTaskText.text != nil), !self.todoTaskText.text!.isEmpty{
//            self.delegate?.getData(data: <#T##String#>)
//        }
        
        self.delegate?.getData(data: todoTaskText.text!)
        self.dismiss(animated: true, completion: nil )
    }
}
