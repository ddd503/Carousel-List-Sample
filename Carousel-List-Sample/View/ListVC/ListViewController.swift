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
            listView.delegate = self
            listView.dataSource = self
            listView.register(ListViewCell.nib(), forCellReuseIdentifier: ListViewCell.identifier)
            listView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        }
    }
    
    var presenter: ListViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.tableViewCellHeight = view.bounds.height / 3.5
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
    
    func transitionDetailVC(shopData: Shop) {
        present(ViewControllerBuilder.buildDetailVC(transitioningDelegate: self, shopData: shopData), animated: true)
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
        cell.setViewData(datasource: self,
                         categoryTitle: presenter.rests[indexPath.row].title,
                         tag: indexPath.row,
                         currentOffsetX: CGFloat(truncating: presenter.collectionViewCurrentOffsetXDic["\(indexPath.row)"] ?? 0))
        return cell
    }
    
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter.tableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // CollectionViewのtag(indexPath.row)をkeyにOffset.xを保存する
        presenter.collectionViewCurrentOffsetXDic["\(indexPath.row)"] = NSNumber(value: Float((cell as? ListViewCell)?.carouselListView.contentOffset.x ?? 0))
    }
    
}

extension ListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.rests[section].shops.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouCell.identifier, for: indexPath) as? CarouCell else {
            fatalError("cell is nil")
        }
        cell.setCellData(data: presenter.rests[collectionView.tag].shops[indexPath.row])
        return cell
    }
    
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let size = presenter.collectionViewCellSize {
            return size
        } else {
            let size = CGSize(width: collectionView.bounds.height / 4 * 2.3 , height: collectionView.bounds.height)
            presenter.collectionViewCellSize = size
            return size
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

extension ListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let carouCell = collectionView.cellForItem(at: indexPath) as? CarouCell else { return }
        presenter.didTapCell(carouCell, restIndex: collectionView.tag, shopIndex: indexPath.row, parentView: view.superview)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CarouCell else { return }
        cell.tappedView.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CarouCell else { return }
        cell.tappedView.isHidden = true
    }
    
}

extension ListViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let objectData = presenter.tappedObjectData else { return nil }
        return CustomAnimator(duration: 0.5, isPresenting: true, objectData: objectData)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let objectData = presenter.tappedObjectData else { return nil }
        return CustomAnimator(duration: 0.5, isPresenting: false, objectData: objectData)
    }
    
}
