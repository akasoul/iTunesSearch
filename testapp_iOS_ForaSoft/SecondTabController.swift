//
//  SecondTabController.swift
//  testapp_iOS_ForaSoft
//
//  Created by Anton Voloshuk on 28.01.2021.
//

import Foundation
import UIKit


class secondTabController: UITableViewController{
    let table=UITableView(frame:.zero)
    var source: UITableViewDataSource?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.source=tableData(model: (self.parent as! tabController).model)
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        self.table.delegate=self
        self.table.dataSource=source
        self.table.allowsSelection=true
        self.view=table
        self.table.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.table.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        (self.parent as! tabController).selectedIndex=0
        (self.parent as! tabController).firstTabView.searchBar.text=(self.parent as! tabController).model.searchHistory[indexPath.item]
//        sleep(1)
//        (self.parent as! tabController).model.newRequest(input: (self.parent as! tabController).model.searchHistory[indexPath.item])
    }

}



class tableData: NSObject, UITableViewDataSource,UITableViewDelegate{
    let cellID="myCell"
    var model: Model
    init(model: Model) {
        self.model=model
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = model.searchHistory.count
        return count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: self.cellID,for: indexPath) //as! tableCell
        cell.textLabel!.text=self.model.searchHistory[indexPath.item]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Search history"
    }
    
}

