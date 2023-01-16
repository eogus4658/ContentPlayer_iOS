//
//  ContentListViewCell.swift
//  ContentPlayer
//
//  Created by 이대현 on 2023/01/09.
//

import UIKit

class ContentListViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = UIColor(named: "CPLightPurple")
            } else {
                backgroundColor = .white
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func set(_ data: Content) {
        self.titleLabel.text = data.Name
        Task {
            if let image = await data.image() {
                self.thumbImageView.image = image
            } else {
                self.thumbImageView.image = UIImage(named: data.ThumbPath)
            }
        }
    }
}
