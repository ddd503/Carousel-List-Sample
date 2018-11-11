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
        cell.setViewData(datasource: self, categoryTitle: presenter.rests[indexPath.row].title, tag: indexPath.row)
        return cell
    }
    
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height / 3.5
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
        return CGSize(width: view.bounds.width / 3.5, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let verticalInset: CGFloat = 10
        return UIEdgeInsets(top: 0, left: verticalInset, bottom: 0, right: verticalInset)
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
