//
//  AddTableViewCell.swift
//  SportTime
//
//  Created by Alex on 15.12.2020.
//

import UIKit


class AddTableViewCell: UITableViewCell {

    let images = UIImageView()
    let labelName = UILabel()
    let labelEx = UILabel()
    let labelRelax = UILabel()
    var descript = String()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.gray
        labelName.backgroundColor = UIColor.white
        labelEx.backgroundColor = UIColor.white
        labelRelax.backgroundColor = UIColor.white
        contentView.addSubview(labelName)
        contentView.addSubview(images)

        contentView.addSubview(labelEx)
        contentView.addSubview(labelRelax)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

       
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let heightcontentView = contentView.frame.size.height
        let widthcontentView = contentView.frame.size.width
        let heightLabels = heightcontentView / 2.5
        let indent = (heightcontentView - (heightLabels * 2)) / 3
        
        images.frame = CGRect(x: 2, y: 2, width: heightcontentView - 4, height: heightcontentView - 4)

        labelName.frame = CGRect(x: heightcontentView + 4, y: indent, width: widthcontentView - (images.frame.width + 14) , height: heightLabels)
        labelName.textAlignment = NSTextAlignment.center
        
        labelEx.frame = CGRect(x: heightcontentView + 4, y: labelName.frame.height + (indent * 2), width: (labelName.frame.width / 2) - 4 , height: labelName.frame.height)
        labelEx.textAlignment = NSTextAlignment.center
        
        labelRelax.frame = CGRect(x: labelEx.frame.origin.x + labelEx.frame.width + 8 , y: labelEx.frame.origin.y, width: labelEx.frame.width , height: labelEx.frame.height)
        labelRelax.textAlignment = NSTextAlignment.center

    }
    

}
