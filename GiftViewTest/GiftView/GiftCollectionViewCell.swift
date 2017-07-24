//
//  GiftCollectionViewCell.swift
//  GiftViewTest
//
//  Created by DSY on 2017/7/24.
//  Copyright © 2017年 DSY. All rights reserved.
//

import UIKit

class GiftCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var giftImage: UIImageView!
    @IBOutlet weak var giftName: UILabel!
    @IBOutlet weak var giftPrice: UILabel!
    @IBOutlet weak var roundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
