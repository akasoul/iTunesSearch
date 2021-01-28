//
//  SecondTabController.swift
//  testapp_iOS_ForaSoft
//
//  Created by Anton Voloshuk on 28.01.2021.
//

import Foundation
import UIKit


class secondTabController: UITableViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        let view=UITableView()
        view.delegate=self
        self.view=view
    }
}

