//
//  RatingsCell.swift
//  FAMACASH
//
//  Created by MD  on 08/07/21.
//

import UIKit

class RatingsCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
    
    //MARK: - Properties
    static let resuseId = "RatingsCell"
    
    var selectedMovieRate: RatingsViewModel? {
        didSet{
            titleLabel.text = selectedMovieRate?.author
            dateLabel.text = selectedMovieRate?.createdAt
            rateLabel.text = "\(selectedMovieRate?.rating ?? 0)"
            descLabel.text = selectedMovieRate?.content
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellBackgroundView.layer.masksToBounds = true
        cellBackgroundView.layer.cornerRadius = 10
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.5)
        layer.shadowOpacity = 0.5
    }
    
    override func prepareForReuse() {
        
    }
    
    
}

