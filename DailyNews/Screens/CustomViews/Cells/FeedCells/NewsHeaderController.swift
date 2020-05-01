//
//  NewsHeaderController.swift
//  DailyNews
//
//  Created by Latif Atci on 4/4/20.
//  Copyright © 2020 Latif Atci. All rights reserved.
//

import UIKit
import SafariServices
import RxSwift
import RxCocoa

class NewsHeaderController: BaseListController, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    var news: PublishSubject<[EverythingPresentation]> = PublishSubject()
    var headerNews: [EverythingPresentation] = []
    let viewModel = NewsViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(SectionsHeaderCell.self, forCellWithReuseIdentifier: cellId)
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        viewModel.fetchNews()

        viewModel.newsForHeader
            .observeOn(MainScheduler.instance)
            .bind(to: self.news)
        .disposed(by: disposeBag)

        news.asObserver()
        .subscribe(onNext: {
            self.headerNews.append(contentsOf: $0)
            self.collectionView.reloadData()
        }).disposed(by: disposeBag)


        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.width / 1.2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let safariVC = SFSafariViewController(url: URL(string: news[indexPath.item].url)!)
//        show(safariVC, sender: nil)
////        self.view.window?.rootViewController?.present(safariVC, animated: true, completion: nil)
//    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerNews.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? SectionsHeaderCell
            else { return UICollectionViewCell() }
        let article = headerNews[indexPath.item]
        cell.newsEverything = article
        cell.scrollIndicator.currentPage = indexPath.item
        return cell
    }
}
