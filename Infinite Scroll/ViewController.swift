//
//  ViewController.swift
//  Infinite Scroll
//
//  Created by Fahim Rahman on 27/3/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data: [Int] = Array()
    let totalData: Int = 500
    var limit: Int = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        
        var index: Int = 0
        while index < limit {
            data.append(index)
            index += 1
        }
    }
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = "###  " + String(indexPath.row) + "  ###"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == data.count - 1 {
            
            // Table view reaches it's last cell so load more content to show :)
            
            if data.count < totalData {
                // Bring more data
                var index = data.count
                limit = index + 30
                
                while index < limit {
                    data.append(index)
                    index += 1
                }
                self.perform(#selector(reloadTableView), with: nil, afterDelay: 1.0)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60.0
    }
    
    
    @objc func reloadTableView() {
        self.tableView.reloadData()
    }
}
