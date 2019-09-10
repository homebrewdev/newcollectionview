//
//  ViewController.swift
//  CollectionView
//
//  Created by Egor Devyatov on 19/08/2019.
//  Copyright © 2019 Egor Devyatov. All rights reserved.
//

import UIKit

class APIViewController: UIViewController {
// MARK: - *** Outlets ***
    @IBOutlet var APICollectionView: UICollectionView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
// MARK: - *** APICollectionView LiveCicle ***
    override func viewDidLoad() {
        super.viewDidLoad()
        // определяем свой лейaут для ячеек
        applyCellLayout()
        // конфигурация запроса и сам запрос к API
        requestAPI()
    }
    
    // как только вью вновь появится на экране надо обновить данные из датасорс и наложить layout ячеек
    override func viewWillAppear(_ animated: Bool) {
        // обновляем данные
        APICollectionView.reloadData()
    }
    
// MARK: - *** Internal Methods ***
// определяем свой лейaут для ячеек
    private func applyCellLayout() {
        APICollectionView.allowsMultipleSelection = true
    
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 64,
                                 height: UIScreen.main.bounds.height / 16)
        APICollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    // запрос к API itunes
    private func requestAPI() {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let url = URL(string: "https://itunes.apple.com/search?term=Hip&limits=10")
        let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print(json)
            } catch {
                print("error in JSONSerialization!")
            }
            })
        task.resume()
    }
}

// MARK: - *** Extension UICollectionViewDelegate, UICollectionViewDataSource ***
// extension для методов UICollectionViewDelegate, UICollectionViewDataSource
extension APIViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // число ячеек коллекции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sourceData.count
    }
    
    // генерация ячеек
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "APICell",
                                                      for: indexPath) as! APICollectionViewCell
        // рандомный цвет ячейки
        cell.contentView.backgroundColor = .random
        
        // радиус скругления
        cell.contentView.layer.cornerRadius = 5
        cell.contentView.layer.masksToBounds = true
        
        return cell
    }
    
    // при нажатии на ячейку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            // добавляем черную рамку вокруг этой ячейки
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.borderWidth = 3
        }
    }
    
    // при нажатии на уже выделенную ячейку - снимаем выделение черной рамкой
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            // убираем черную рамку, путем ширина рамки = 0
            cell.contentView.layer.borderWidth = 0
        }
    }
}

// MARK: - *** Keyboard Autohide using UITextFieldDelegate ***
// реализация автоскрытия (autohide) клавиатуры
extension APIViewController: UITextFieldDelegate {
    // для autohide клавиатуры по тапу на любое место экрана
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    
    // для скрытия (autohide) клавиатуры по нажатию на клаве кнопки "return"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
