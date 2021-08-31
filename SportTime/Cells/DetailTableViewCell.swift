//
//  DetailTableViewCell.swift
//  SportTime
//
//  Created by Alex on 07.02.2021.
//

import UIKit

protocol DetailTableViewCellDelegate: class {
    func infoCell(deskription: String)
}

class DetailTableViewCell: UITableViewCell {
    
    weak var myDelegate: DetailTableViewCellDelegate?

    let images = UIImageView()
    let labelName = UILabel()
    let labelEx = UILabel()
    let labelRelax = UILabel()
    let labelDeskription = UILabel()
   // var textInButton = "test"
  
    let buttons: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.systemBlue
        button.setTitle("i", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        
       
     //   contentView.backgroundColor = UIColor.gray

        labelName.backgroundColor = UIColor.white
        labelEx.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        labelRelax.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        contentView.addSubview(labelName)
        contentView.addSubview(images)
        contentView.addSubview(buttons)
        contentView.addSubview(labelEx)
        contentView.addSubview(labelRelax)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

        @objc func addCell(){
            myDelegate?.infoCell(deskription: labelDeskription.text!)
            print("addCell")
        }

    override func layoutSubviews() {
        super.layoutSubviews()
        let heightcontentView = contentView.frame.size.height
        let widthcontentView = contentView.frame.size.width
        let heightLabels = heightcontentView / 2.5
        let indent = (heightcontentView - (heightLabels * 2)) / 3
        
        images.frame = CGRect(x: 2, y: 2, width: heightcontentView - 4, height: heightcontentView - 4)
        buttons.frame = CGRect(x: widthcontentView - (heightcontentView / 3) - 6 , y: heightcontentView / 3, width: heightcontentView / 3, height: heightcontentView / 3)
        
        let widthWithountImageAndButton = widthcontentView - images.frame.width - buttons.frame.width - 20
        labelName.frame = CGRect(x: heightcontentView + 4, y: indent, width: widthWithountImageAndButton , height: heightLabels)
        labelName.textAlignment = NSTextAlignment.center
        
        labelEx.frame = CGRect(x: heightcontentView + 4, y: labelName.frame.height + (indent * 2), width: (labelName.frame.width / 2) - 4 , height: labelName.frame.height)
        labelEx.textAlignment = NSTextAlignment.center
        
        labelRelax.frame = CGRect(x: labelEx.frame.origin.x + labelEx.frame.width + 8 , y: labelEx.frame.origin.y, width: labelEx.frame.width , height: labelEx.frame.height)
        labelRelax.textAlignment = NSTextAlignment.center

        buttons.layer.cornerRadius = buttons.bounds.width / 2
        buttons.addTarget(self, action: #selector(addCell), for: .touchUpInside)
    }
}
