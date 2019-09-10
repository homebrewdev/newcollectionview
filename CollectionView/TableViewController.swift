//
//  TableViewController.swift
//  CollectionView
//
//  Created by Egor Devyatov on 19/08/2019.
//  Copyright © 2019 Egor Devyatov. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
// MARK: - Table view LiveCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Data Source:")
        print(sourceData)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // обновляем данные, так как пользователь мог поредактировать элементы
        // на экране ParametersViewController и внес новые данные в sourceData
        tableView.reloadData()
    }
}

// MARK: - Extension UITableViewDelegate, UITableViewDataSource
// extension для методов UITableViewDelegate, UITableViewDataSource
extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    // количество строк таблицы = кол-во эдлементов в массиве sourceData
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourceData.count
    }
    
    // Задаем хедер таблицы
    func tableView(_ tableView: UITableView, titleForHeaderInSection
        section: Int) -> String? {
        return "Elements"
    }
    
    // Задаем футер таблицы
    func tableView(_ tableView: UITableView, titleForFooterInSection
        section: Int) -> String? {
        return "End of Elements"
    }
    
    // формирование ячейки таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sourceData[indexPath.row] // берем данные и в лейблу
        cell.textLabel?.textAlignment = .natural
        cell.textLabel?.textColor = .random
        
        return cell
    }
    
    // метод вызываемый по нажатию на ячейку таблицы UITableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Нажата ячейка c индексом: \(indexPath.row)")
    }
    
    // задаем название кнопки "удалить" при удалении строки таблицы
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
    
    // включаем для того, чтобы можно было редактировать ячейки таблицы
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // поддержка кнопок удаление и вставки
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // существенный момент в том что сначала надо удалить данные из datasource
            // и только потом вызвать метод tableView.deleteRows(at: [indexPath], with: .fade)
            // иначе крашнется приложение
            // удаляем в массиве строку
            sourceData.remove(at: indexPath.row)
            // удаляем из tableView
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
        
        if editingStyle == .insert {
            sourceData.insert("new element", at: sourceData.count+1)
            
            tableView.insertRows(at: [indexPath], with: .bottom)
            tableView.reloadData()
        }
    }

}
