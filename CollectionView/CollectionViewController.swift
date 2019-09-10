//
//  CollectionViewController.swift
//  CollectionView
//
//  Created by Egor Devyatov on 20/08/2019.
//  Copyright © 2019 Egor Devyatov. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    // MARK: - CollectionViewController LiveCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        // определяем свой лейоут для ячеек
        applyLayout()
    }
    
    // как только вью вновь появится на экране надо обновить данные из датасорс и наложить layout ячеек
    override func viewWillAppear(_ animated: Bool) {
        // обновляем данные
        myCollectionView.reloadData()
    }
    
    // определяем свой лейоут для ячеек
    private func applyLayout() {
        myCollectionView.allowsMultipleSelection = true
    
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: elementSize, height: elementSize)
        myCollectionView.setCollectionViewLayout(layout, animated: true)
    }
}

    
// MARK: - Extension UICollectionViewDelegate, UICollectionViewDataSource
// extension для методов UICollectionViewDelegate, UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // количество элементов в секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let collectionItems = sourceData.count
        return collectionItems
    }

    // конфигурация ячейки
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
        UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell",
                                                      for: indexPath) as! CollectionViewCell
        // рандомный цвет ячейки
        cell.contentView.backgroundColor = .random
        
        // радиус скругления
        cell.contentView.layer.cornerRadius = 5
        cell.contentView.layer.masksToBounds = true
        
        cell.collectionCellLabel.text = sourceData[indexPath.row] // текст лейбла
        
        return cell
    }
    
    // рисуем рамку, если мы нажали клетку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            
        print("superlayer = \(String(describing: cell.contentView.layer.superlayer))")
        print("Added layer = \(String(describing: cell.contentView.layer))")
        
        // добавляем черную рамку вокруг этой ячейки
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.layer.borderWidth = 3
            
        // добавим блок анимации угасания клетки с alpha = 1.0 до 0.0 c длительностью 1.5 сек
        UIView.animate(withDuration: 1.5, animations: {
            cell.contentView.alpha = 0.0
        })
        }
    }
   
    // стираем рамку если мы нажали клетку, которую уже выбирали
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
        // убираем черную рамку, путем ширина рамки = 0
            cell.contentView.layer.borderWidth = 0
        
            // добавим блок анимации появления клетки с alpha = 0.0 до 1.0 c длительностью 1.5 сек
            UIView.animate(withDuration: 1.5, animations: {
                cell.contentView.alpha = 1.0
                })
        }
    }
    
}
