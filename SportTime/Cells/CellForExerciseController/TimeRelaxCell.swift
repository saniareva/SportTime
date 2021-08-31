//
//  TimeRelaxCell.swift
//  SportTime
//
//  Created by Alex on 20.05.2021.
//

import UIKit

class TimeRelaxCell: UITableViewCell {
    
    let timeRelax = UILabel()
    let descriptionTimeRelax = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.gray
        timeRelax.backgroundColor = UIColor.yellow
        descriptionTimeRelax.backgroundColor = UIColor.green
        
        contentView.addSubview(timeRelax)
        contentView.addSubview(descriptionTimeRelax)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let heightcontentView = contentView.frame.size.height
        let widthcontentView = contentView.frame.size.width
        
        timeRelax.frame = CGRect(x: 5 , y: 2, width: (widthcontentView / 3) - 5 , height: heightcontentView - 4)
        timeRelax.textAlignment = NSTextAlignment.center
        
        let descriptionTimeExerciseX = timeRelax.frame.origin.x + timeRelax.frame.width + 5
        let descriptionTimeExerciseWidth = widthcontentView - (timeRelax.frame.width + 5) - 5
        descriptionTimeRelax.frame = CGRect(x: descriptionTimeExerciseX , y: 2, width: descriptionTimeExerciseWidth , height: heightcontentView - 4)
        descriptionTimeRelax.textAlignment = NSTextAlignment.center
    }
}
