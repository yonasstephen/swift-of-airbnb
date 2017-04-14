//
//  ViewController.swift
//  custom-controller-transition
//
//  Created by Yonas Stephen on 9/4/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    let cellID = "cellID"
    let imageExpandAnimationController = ImageExpandAnimationController()
    
    var homes: [String] = {
        var arr = [String]()
        for i in 0..<10 {
            arr.append("home-" + "\(i + 1)")
        }
        return arr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        
        view.backgroundColor = UIColor.white
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.itemSize = CGSize(width: 280, height: 250)
        }
        
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(CustomCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.dataSource = self
        
        collectionView?.heightAnchor.constraint(equalToConstant: 250).isActive = true
        collectionView?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView?.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CustomCell
        
        cell.delegate = self
        cell.imageName = homes[indexPath.item]
        
        return cell
        
    }
}

extension ViewController: CustomCellDelegate {
    func didSelect(_ customCell: CustomCell) {
        let relativeToCell = customCell.convert(customCell.imageView.frame, to: collectionView)
        let relativeToCollectionView = collectionView?.convert(relativeToCell, to: view)
        imageExpandAnimationController.originFrame = relativeToCollectionView!
        
        let detailVC = DetailViewController()
        detailVC.imageName = customCell.imageName
        detailVC.transitioningDelegate = self
        
        present(detailVC, animated: true, completion: nil)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return imageExpandAnimationController
    }
}

