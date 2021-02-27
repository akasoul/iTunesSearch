//
//  MainController.swift
//  testapp3_iOS
//
//  Created by Anton Voloshuk on 22.01.2021.
//

import Foundation
import UIKit



class tabController: UITabBarController,UITabBarControllerDelegate{
    let firstTabView=firstTabController()
    let secondTabView=secondTabController()
    let model=Model()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate=self
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.firstTabView.tabBarItem=UITabBarItem(tabBarSystemItem: .search, tag: 0)
        self.secondTabView.tabBarItem=UITabBarItem(tabBarSystemItem: .history, tag: 1)
        self.viewControllers=[self.firstTabView,self.secondTabView]
        self.view.backgroundColor=UIColor.white
    }
}










