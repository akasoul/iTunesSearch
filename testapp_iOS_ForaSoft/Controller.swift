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
    let firstTabView=firstTabController()
    let secondTabView=secondTabController()
    let hst=historyTmp()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate=self
        
        
    }
    func showPopup(){
        
        let rootVC=testViewController()
        rootVC.title="test title"
        let navVC=UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .popover
        navVC.modalTransitionStyle = .coverVertical
        navVC.view.frame=CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height*0.5)
        rootVC.navigationItem.leftBarButtonItem=UIBarButtonItem(title: "back")
        present(navVC, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.firstTabView.tabBarItem=UITabBarItem(tabBarSystemItem: .search, tag: 0)
        self.secondTabView.tabBarItem=UITabBarItem(tabBarSystemItem: .history, tag: 1)
        self.viewControllers=[self.firstTabView,self.secondTabView]
        self.view.backgroundColor=UIColor.white
    }
}

class firstTabController: UINavigationController,UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    let info = testViewController()
    let searchBar=UISearchBar()
    let collectionViewLayout=UICollectionViewLayout()
    var response: jsonStruct?
    var albums: [String]=[]
    var artworks:[UIImage?]=[]
    var showCollection=true
    let reuseCellId="cell"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.albums.count
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 50, left: 50, bottom: 50, right: 50)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let offset = indexPath.last! * 110
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell2
        if(self.artworks[indexPath.item] != nil){
            cell.data=CustomData(title: self.albums[indexPath.item], url: "dsds", backgroundImage: self.artworks[indexPath.item]!)
        }
            //cell.contentConfiguration=UIListContentConfiguration.subtitleCell()
//        cell.backgroundColor=UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
//        cell.backgroundView=UIImageView(image: self.artworks[indexPath.last!])
//
//        let label=UILabel()
//        label.bounds=cell.bounds
//        label.textAlignment = .right
//        label.text=self.albums[indexPath.last!]
//        cell.addSubview(label)
        

        print(indexPath.item)
        return cell
    }
    
    

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("selected at: ")
        print(indexPath.first)
        print(indexPath.last)
        print(indexPath.row)
        
        (self.parent as! tabController).showPopup()
        //self.showDetailViewController(self.info, sender: nil)
//        let newvc=UIViewController()
//        newvc.view=UIView(frame: self.view.frame)
//        newvc.view.backgroundColor = .yellow
//        newvc.navigationController?.navigationItem.leftBarButtonItem=UIBarButtonItem(title: "back")
//        self.pushViewController(newvc, animated: true)
        
//
//        let rootVC=testViewController()
//        rootVC.title="test title"
//        let navVC=UINavigationController(rootViewController: rootVC)
//        //navVC.view=UIView()
//        //navVC.view.backgroundColor = .purple
//        navVC.modalPresentationStyle = .fullScreen
//        rootVC.navigationItem.leftBarButtonItem=UIBarButtonItem(title: "back")
//        present(navVC, animated: true)
        
        //self.showCollection=false
        //self.viewDidLoad()
    }

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell2.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.searchBar.delegate=self
        self.searchBar.frame=CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height*0.2)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .horizontal
        
        let tabBarHeight=(parent as! UITabBarController).tabBar.frame.height
        print(tabBarHeight)
        let collectionFrame=CGRect(x: 0, y: self.view.frame.height*0.2, width: self.view.frame.width, height: self.view.frame.height*0.8-tabBarHeight)
        
        
        let customCellNib=UINib(nibName: "CustomCell2", bundle: .main)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(customCellNib, forCellWithReuseIdentifier: "cell")
        let collectionView=UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(customCellNib, forCellWithReuseIdentifier: "cell")
        collectionView.frame=collectionFrame
        
        collectionView.isScrollEnabled=true
        collectionView.scrollIndicatorInsets = .zero
        collectionView.showsHorizontalScrollIndicator=true
        collectionView.isPagingEnabled=true
        collectionView.contentInset = .zero
        collectionView.delegate=self
        collectionView.dataSource=self
        collectionView.backgroundColor=UIColor.lightGray
        view.addSubview(collectionView)
        
        
        
        
        print(self.navigationController)
        self.view.addSubview(self.searchBar)
    }
    
    func closeInfoView(){
        self.showCollection=true
        self.viewDidLoad()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(self.searchBar.text != nil){
            var path = "https://itunes.apple.com/search?term="
            (parent as! tabController).hst.arr.append(self.searchBar.text!)
            path.append(self.searchBar.text!)
            path.append("&country=ru&limit=100000")
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
            var imgLinks=[String]()
            for i in 0..<self.response!.results.count{
                if(self.response!.results[i].collectionName != nil && self.response!.results[i].artworkUrl100 != nil){
                    var append=true
                    for j in 0..<self.albums.count{
                        if(self.albums[j]==self.response!.results[i].collectionName){
                            append=false
                        }
                    }
                    if(append){
                        self.albums.append(self.response!.results[i].collectionName!)
                        imgLinks.append(self.response!.results[i].artworkUrl100!)
                        
                    }
                }
            }
            
            self.artworks=[UIImage?].init(repeating: nil, count: self.albums.count)
            let group=DispatchGroup()
            group.enter()
            for i in 0..<self.artworks.count{
                DispatchQueue.global().async{
                    let url=URL(string: imgLinks[i])!
                    var img: UIImage?
                    var imgData: Data?
//                    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
//                        guard let data = data else { return }
//                        img=UIImage(data: data)
//                        do{
//                            self.response = try JSONDecoder().decode(jsonStruct.self, from: answer.data(using: .utf8)!)
//                        }
//                        catch{
//                            print(error)
//                        }
//                    }
//
//                    task.resume()
//                    while !task.progress.isFinished{
//                        sleep(1)
//                    }
                    do{
                    imgData = try Data(contentsOf: url)
                    }
                    catch{
                    }
                    if(imgData != nil){
                        img=UIImage(data: imgData!)
                    }
                    self.artworks[i]=img
                    //group.leave()
                    print("exit thread")
                    DispatchQueue.main.sync{
                    self.view.endEditing(true)
                    self.viewDidLoad()
                    }
                }
            }
            
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


class testViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(self.close))
        print("tvc didload")
        self.view=UIView(frame: .zero)
        self.view.backgroundColor=UIColor.red
    }
    @objc func close(){
        self.dismiss(animated: true)
    }
}

class infoViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view=UIView(frame: .zero)
        self.view.backgroundColor = .orange
            let navVC=UINavigationController(rootViewController: self)
        navVC.modalPresentationStyle = .fullScreen
        navVC.navigationItem.leftBarButtonItem=UIBarButtonItem(title: "back")
        self.view.addSubview(navVC.view)
    }
}



class popupView: UIView {
  
     override init(frame: CGRect)   {
         super.init(frame: frame)
        self.backgroundColor = .orange
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
