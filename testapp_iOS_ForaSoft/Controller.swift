//
//  MainController.swift
//  testapp3_iOS
//
//  Created by User on 22.01.2021.
//

import Foundation
import UIKit

class historyTmp{
    var arr=[String](){
        didSet{
            print(self.arr)
        }
    }
}

class tabController: UITabBarController,UITabBarControllerDelegate{
    let mainView=UITabBar()
    let firstTabView=firstTabController()
    let secondTabView=secondTabController()
    let hst=historyTmp()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate=self
        
        
  }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.firstTabView.tabBarItem=UITabBarItem(tabBarSystemItem: .search, tag: 0)
        self.secondTabView.tabBarItem=UITabBarItem(tabBarSystemItem: .history, tag: 1)

        self.viewControllers=[self.firstTabView,self.secondTabView]
        self.view.backgroundColor=UIColor.purple
    }
}

class firstTabController: UIViewController,UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    let searchBar=UISearchBar()
    var collectionView: UICollectionView! = nil
    let collectionViewLayout=UICollectionViewLayout()
    var response: jsonStruct?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
        if(self.response != nil){
            return self.response!.resultCount
        }
        return 10
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
              .dequeueReusableCell(withReuseIdentifier: "reuseIdentifier", for: indexPath)
            cell.backgroundColor = .black
            // Configure the cell
        cell.frame=CGRect(x: 0, y: 0, width: 100, height: 100)
        cell.backgroundColor=UIColor.red
        let textView=UITextView()
        
        let a = indexPath.last! * 100
        print(a)
        textView.frame=CGRect(x: a, y: 0, width: 100, height: 100)
        textView.text=String(indexPath.last!)
        cell.addSubview(textView)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 20, height: 20)
    }
    //let collectionView=UICollectionView(frame: CGRect(x: self.view.frame.height*0.2, y: 0, width: self.view.frame.width, height: self.view.frame.height*0.8), collectionViewLayout: collectionViewLayout)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate=self
        self.view.backgroundColor=UIColor.red
        self.searchBar.frame=CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height*0.2)

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
            layout.itemSize = CGSize(width: 100, height: 100)
        
        self.collectionView=UICollectionView(frame: CGRect(x: 0, y: self.view.frame.height*0.2, width: self.view.frame.width, height: self.view.frame.height*0.8), collectionViewLayout: layout)
        collectionView.contentInset = .zero
        collectionView.delegate=self
        collectionView.dataSource=self
        collectionView.backgroundColor=UIColor.lightGray
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "reuseIdentifier")
        
        self.view.addSubview(self.searchBar)
        self.view.addSubview(collectionView)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print(self.searchBar.text)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //print("click")
        if(self.searchBar.text != nil){
            var path = "https://itunes.apple.com/search?term="
            (parent as! tabController).hst.arr.append(self.searchBar.text!)
            path.append(self.searchBar.text!)
            path.append("&country=ru")
            let url = URL(string: path)!
            var answer=""
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                answer=(String(data: data, encoding: .utf8)!)
                do{
                    self.response = try JSONDecoder().decode(jsonStruct.self, from: answer.data(using: .utf8)!)
                }
                catch{
                    print(error)
                }
            }
            
            task.resume()
            while !task.progress.isFinished{
                sleep(1)
            }
            self.setNeedsFocusUpdate()
        }
    }
}

class secondTabController: UITableViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        let view=UITableView()
        view.delegate=self
        self.view=view
    }
}






struct jsonStruct: Encodable,Decodable {
    struct Result: Encodable, Decodable {
        let wrapperType: String?
        let kind: String?
        let artistId, collectionId, trackId: Int?
        let artistName: String?
        let collectionName, trackName, collectionCensoredName, trackCensoredName: String?
        let artistViewUrl, collectionViewUrl, trackViewUrl: String?
        let previewUrl: String?
        let artworkUrl30, artworkUrl60, artworkUrl100: String?
        let collectionPrice, trackPrice: Double?
        let releaseDate: String?
        let discCount, discNumber, trackCount, trackNumber: Int?
        let trackTimeMillis: Int?
        let country: String?
        let currency: String?
    }
    let resultCount: Int
    let results: [Result]
}


