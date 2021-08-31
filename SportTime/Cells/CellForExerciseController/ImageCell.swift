//
//  ImageCell.swift
//  SportTime
//
//  Created by Alex on 27.05.2021.
//

import UIKit

class ImageCell: UITableViewCell {
    
    let myImage = UIImageView()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        contentView.addSubview(myImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        let heightcontentView = contentView.frame.size.height
        let widthcontentView = contentView.frame.size.width

        myImage.frame = CGRect(x: 5 , y: 2, width: widthcontentView  - 10 , height: heightcontentView - 4)
       
        
       
        myImage.layer.borderWidth = 1
        myImage.layer.borderColor = UIColor.black.cgColor
       // myPicker.layer.cornerRadius = myPicker.bounds.width / 20

        addSubview(myImage)
    }

}
