//
//  NewsViewModel.swift
//  DailyNews
//
//  Created by Latif Atci on 4/27/20.
//  Copyright © 2020 Latif Atci. All rights reserved.
//

import Foundation
import RxSwift

final class NewsViewModel {

    let service = FetchNews()
    var newsForHeader: PublishSubject<[EverythingPresentation]> = PublishSubject()
    var newsForCells: PublishSubject<[EverythingPresentation]> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()

    func fetchNews() {
        let dispatchQueue = DispatchQueue(label: "com.latifatci.DailyNews", qos: .background, attributes: .concurrent)
        let dispatchGroup = DispatchGroup()
        self.loading.onNext(true)
        dispatchGroup.enter()
        dispatchQueue.async {
            self.service.fetchNewsFromEverything(ERequest(qWord: nil, qInTitle: nil, domains: nil, excludeDomains: nil, fromDate: nil, toDate: nil, language: "en", sortBy: .publishedAt, pageSize: 10, page: 2, sources: Constants.sourcesIds)) { (result) in
                switch result {
                case .success(let news):
                    
                    let cellNews = news.articles.map({EverythingPresentation.init(everything: $0)})
                    self.newsForCells.onNext(cellNews)
                case .failure(let err):
                    print(err)
                }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.enter()
        dispatchQueue.async {
            self.service.fetchNewsFromEverything(ERequest(qWord: nil, qInTitle: nil, domains: nil, excludeDomains: nil, fromDate: nil, toDate: nil, language: "en", sortBy: .publishedAt, pageSize: 10, page: 1, sources: Constants.sourcesIds)) { (result) in
                switch result {
                case .success(let news):
                    let headerNews = news.articles.map({EverythingPresentation.init(everything: $0)})
                    self.newsForHeader.onNext(headerNews)
                case .failure(let err):
                    print(err)
                }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.loading.onNext(false)
        }
        
        
        
    }
}
