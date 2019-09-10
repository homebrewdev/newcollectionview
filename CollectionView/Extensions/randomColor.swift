//
//  randomColor.swift
//  CollectionView
//
//  Created by Egor Devyatov on 23/08/2019.
//  Copyright © 2019 Egor Devyatov. All rights reserved.
//
import UIKit

// для генерации рандомных цветов
extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
