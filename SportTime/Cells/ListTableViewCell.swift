//
//  ListTableViewCell.swift
//  SportTime
//
//  Created by Alex on 15.12.2020.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    var lableCell = UILabel()
    var lableName = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.gray
        lableName.backgroundColor = UIColor.white
        lableCell.backgroundColor = UIColor.white
        
        contentView.addSubview(lableName)
        contentView.addSubview(lableCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let heightcontentView = contentView.frame.size.height
        let widthcontentView = contentView.frame.size.width

        lableName.frame = CGRect(x: 5 , y: 2, width: widthcontentView / 3 , height: heightcontentView - 4)
        lableName.textAlignment = NSTextAlignment.center
        lableCell.frame = CGRect(x: 150 , y: 2, width: widthcontentView / 3 , height: heightcontentView - 4)
        lableCell.textAlignment = NSTextAlignment.center
    }
}
