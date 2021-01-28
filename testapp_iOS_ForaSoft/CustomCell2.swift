//
//  CustomCell2.swift
//  testapp_iOS_ForaSoft
//
//  Created by User on 27.01.2021.
//

import UIKit

class CustomCell2: UICollectionViewCell {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    
    
    var data: CustomData? {
        didSet {
            
            guard let data = data else { return }
            self.img.image = data.backgroundImage
            self.lbl.text=data.title
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.view.layer.cornerRadius=35
    }
  
}
