//
//  CustomCollectionViewCell.swift
//  testapp_iOS_ForaSoft
//
//  Created by User on 25.01.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func config(text: String){
        self.label.text=text
    }

}

class customCell: UICollectionViewCell{
    var label: UILabel = {
        let label = UILabel()
        label.text=""
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.contentView.addSubview(self.label)
    }
    func setText(text:String){
        self.label=UILabel(frame: .zero)
        self.label.text=text
        self.contentView.addSubview(self.label)}
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
