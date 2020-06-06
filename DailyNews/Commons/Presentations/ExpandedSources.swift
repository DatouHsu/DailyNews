//
//  ExpandedSources.swift
//  DailyNews
//
//  Created by Latif Atci on 4/1/20.
//  Copyright © 2020 Latif Atci. All rights reserved.
//

import Foundation
import RxDataSources

final class ExpandedSources {
    var category: SourceCategories
    var sources: [Sources]
    
    init(category: SourceCategories, sources: [Sources]) {
        self.category = category
        self.sources = sources
    }
}
struct ExpandedSourcesSectionModel {
    var items: [ExpandedSources]
}

extension ExpandedSourcesSectionModel: SectionModelType {
    
    init(original: ExpandedSourcesSectionModel, items: [ExpandedSources]) {
        self = original
        self.items = items
    }
}

