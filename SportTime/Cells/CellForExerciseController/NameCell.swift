//
//  NameCellTableViewCell.swift
//  SportTime
//
//  Created by Alex on 20.05.2021.
//

import UIKit

class NameCell: UITableViewCell {

    let textFieldName = UITextField()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.gray
        textFieldName.backgroundColor = UIColor.yellow
        textFieldName.placeholder = "Name"
        contentView.addSubview(textFieldName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let heightcontentView = contentView.frame.size.height
        let widthcontentView = contentView.frame.size.width

        textFieldName.frame = CGRect(x: 5 , y: 2, width: widthcontentView - 10 , height: heightcontentView - 4)
        textFieldName.textAlignment = NSTextAlignment.center
    }
    
}
