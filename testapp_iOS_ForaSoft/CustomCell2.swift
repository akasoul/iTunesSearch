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
        self.view.awakeFromNib()
        self.lbl.awakeFromNib()
        self.img.awakeFromNib()
        // Initialization code

    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.awakeFromNib()
        self.view=UIView()
        self.lbl=UILabel()
        self.img=UIImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
