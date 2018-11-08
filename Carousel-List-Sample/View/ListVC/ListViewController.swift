//
//  ListViewController.swift
//  Carousel-List-Sample
//
//  Created by kawaharadai on 2018/11/07.
//  Copyright © 2018 kawaharadai. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {
    
    @IBOutlet weak var listView: UITableView! {
        didSet {
            listView.dataSource = self
            listView.register(UINib(nibName: ListViewCell.identifier, bundle: nil),
                              forCellReuseIdentifier: ListViewCell.identifier)
            listView.tableFooterView = UIView()
        }
    }
    
    var presenter: ListViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.requestDatasource()
    }
    
}

extension ListViewController: ListViewPresenterInterface {
    
    func reload() {
        DispatchQueue.main.async {
            self.listView.reloadData()
        }
    }
    
    func showErrorAlert(title: String?, message: String?, action: ((UIAlertAction) -> ())?) {
        AlertHelper.showDefaultErrorAlert(title: title, message: message, action: action)
    }
    
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.rests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListViewCell.identifier, for: indexPath) as? ListViewCell else {
            fatalError("cell is nil")
        }
        cell.setDatasource(self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height / 3.5
    }
    
}

extension ListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderView.identifier, for: indexPath) as? TitleHeaderView else {
            fatalError("Could not find header")
        }
        if kind == UICollectionView.elementKindSectionHeader {
            header.title = presenter.rests[indexPath.section].title
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.rests[section].shops.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouCell.identifier, for: indexPath) as? CarouCell else {
            fatalError("cell is nil")
        }
        cell.setCellData(data: presenter.rests[indexPath.section].shops[indexPath.row])
        return cell
    }
    
    
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width / 3.5, height: collectionView.bounds.height)
    }
    
    // categoryCell表示領域とCollectionViewの上下左右の余白を設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let verticalInset: CGFloat = 10
        return UIEdgeInsets(top: 0, left: verticalInset, bottom: 0, right: verticalInset)
    }
    
    // categoryCellの左右の余白の最小値を設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

extension ListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
