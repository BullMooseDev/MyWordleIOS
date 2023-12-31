//
//  BoardViewController.swift
//  MyWordle
//
//  Created by kole ervine on 10/17/23.
//

import UIKit

protocol BoardViewControllerDataSource: AnyObject {
    var currentGuesses: [[Character?]] { get }
}

class BoardViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
   
    var dataSource: BoardViewControllerDataSource?
    
    private let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 4
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.backgroundColor = .black
            collectionView.register(KeyCell.self, forCellWithReuseIdentifier: KeyCell.identifier)
            return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.backgroundColor = .lightGray
        collectionView.backgroundColor = .lightGray
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    
    public func reloadData() {
        collectionView.reloadData()
        }
    }

    extension BoardViewController {
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return dataSource?.currentGuesses.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            let guesses = dataSource?.currentGuesses ?? []
            return guesses.count
        }
        
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCell.identifier, for: indexPath) as? KeyCell else {
                fatalError()
            }
            cell.backgroundColor = .darkGray
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.cornerRadius = 4
            
            let guesses = dataSource?.currentGuesses ?? []
            if let letter = guesses[indexPath.section][indexPath.row] {
                cell.configureWithLetter(with: letter)
            }
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let margin: CGFloat = 20
            let size: CGFloat = (collectionView.frame.size.width-margin)/5
            
            return CGSize(width: size, height: size)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            
            return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            //
        }
    }
