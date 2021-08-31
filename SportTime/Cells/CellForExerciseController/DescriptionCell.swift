//
//  DescriptionCell.swift
//  SportTime
//
//  Created by Alex on 20.05.2021.
//

import UIKit


class DescriptionCell: UITableViewCell {

    var textViewDescription = UITextView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.gray
        textViewDescription.backgroundColor = .white
        textViewDescription.textContainer.maximumNumberOfLines = 20
        textViewDescription.font = .systemFont(ofSize: 21.0)
        textViewDescription.textContainer.lineBreakMode = .byWordWrapping
      //  textViewDescription.delegate = self
        textViewDescription.textColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.30)
      //  upDownViewForKeyboard()
        contentView.addSubview(textViewDescription)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let heightcontentView = contentView.frame.size.height
        let widthcontentView = contentView.frame.size.width

        textViewDescription.frame = CGRect(x: 5 , y: 2, width: widthcontentView - 10 , height: heightcontentView - 4)
        textViewDescription.textAlignment = NSTextAlignment.center
    }
    
}

