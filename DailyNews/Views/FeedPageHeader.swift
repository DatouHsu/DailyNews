//
//  FeedPageHeader.swift
//  DailyNews
//
//  Created by Latif Atci on 3/7/20.
//  Copyright © 2020 Latif Atci. All rights reserved.
//

import UIKit

class FeedPageHeader: UICollectionReusableView {
    
    let feedHeaderController = FeedHeaderController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(feedHeaderController.view)
        feedHeaderController.view.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
