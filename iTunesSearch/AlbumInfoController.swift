//
//  AlbumInfoController.swift
//  iTunesSearch
//
//  Created by Anton Voloshuk on 28.01.2021.
//

import Foundation
import UIKit




class AlbumInfoController: UIViewController{
    var album: album?{
        didSet{
            if(self.album != nil){
                if(self.album!.songs != nil){
                    self.songNames=[UILabel].init(repeating: UILabel(), count: self.album!.songs!.count)
                    for i in 0..<self.album!.songs!.count{
                        self.songNames[i].text=self.album!.songs![i].name
                    }
                }
            }
            let imgView=UIImageView(image: self.album!.cover!)
            imgView.frame=self.view.frame
            self.view.addSubview(imgView)
            //self.viewDidLoad()
        }
    }
    
    var songNames: [UILabel]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(self.close))

        self.view=UIView(frame: .zero)
        self.view.backgroundColor=UIColor.purple
        let label = UILabel()
        label.bounds=self.view.bounds
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.text="SDADASDASDA"
        self.view.addSubview(label)
//        let scrollView=UIScrollView(frame: self.view.frame)
//        let vstack=UIStackView(arrangedSubviews: self.songNames)
//        vstack.frame=self.view.frame
//        vstack.backgroundColor = .white
//        self.view.addSubview(vstack)
//        self.view.addSubview(scrollView)
    }
    @objc func close(){
        self.dismiss(animated: true)
    }
}
