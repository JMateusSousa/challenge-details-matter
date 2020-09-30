//
//  OnboardingVIew.swift
//  DetailsMatter
//
//  Created by Tales Conrado on 29/09/20.
//  Copyright © 2020 Tales Conrado. All rights reserved.
//

import UIKit

class OnboardingView: UIView {
    lazy var collectionView: UICollectionView = {
        // Init flow layout horizontal
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        // Init collection
        let col = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        col.translatesAutoresizingMaskIntoConstraints = false
        col.isPagingEnabled = true
        col.delegate = self
        col.dataSource = self
        col.backgroundColor = .gray
        col.showsHorizontalScrollIndicator = false

        return col
    }()

    let pageControl: UIPageControl = {
        let page = UIPageControl()
        page.translatesAutoresizingMaskIntoConstraints = false
        page.numberOfPages = 3
        page.currentPage = 0
        page.pageIndicatorTintColor = .gray
        page.currentPageIndicatorTintColor = .primary
        page.isUserInteractionEnabled = false

        return page
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.contentInsetAdjustmentBehavior = .never
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        self.addSubview(collectionView)
        self.addSubview(pageControl)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),

            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40)
        ])
    }
}

extension OnboardingView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    //swiftlint:disable force_cast
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnboardingCell
        cell.configure(position: indexPath.item)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.width, height: frame.height - 60)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(collectionView.contentOffset.x / collectionView.frame.size.width)
    }
}
