//
//  FeedViewController.swift
//  DailyNews
//
//  Created by Latif Atci on 3/3/20.
//  Copyright © 2020 Latif Atci. All rights reserved.
//

import UIKit

class BusinessCategoryController: FeaturedCategoryController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override init(_ viewModel: SectionsViewModel = SectionsViewModel(NewsService(), THCategories.business), _ category: THCategories = .business) {
        super.init(viewModel,category)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
