//
//  CustomCell.swift
//  testapp_iOS_ForaSoft
//
//  Created by Anton Voloshuk on 27.01.2021.
//

import Foundation
import UIKit


struct CustomData {
    var title: String
    var url: String
    var backgroundImage: UIImage
}

class CustomCell: UICollectionViewCell {
    

    var data: CustomData? {
        didSet {
            guard let data = data else { return }
            bg.image = data.backgroundImage
            bg.frame=CGRect(origin: CGPoint(x: self.contentView.frame.width*0.5, y: self.contentView.frame.height*0.5), size: bg.image!.size)
            label.text=data.title
        }
    }
    let label: UILabel = {
        let lb=UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.contentMode = .scaleAspectFill
        lb.textAlignment = .center
        lb.font=UIFont.systemFont(ofSize: 10)
       return lb
    }()
    fileprivate let bg: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        
       // iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
                iv.layer.cornerRadius = 12
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .yellow
        contentView.addSubview(bg)
        
        //bg.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        bg.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        bg.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        //bg.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
//        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        contentView.addSubview(label)
//        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.topAnchor.constraint(equalTo: bg.lastBaselineAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        //label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
