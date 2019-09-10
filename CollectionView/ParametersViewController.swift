//
//  ParametersViewController.swift
//  CollectionView
//
//  Created by Egor Devyatov on 19/08/2019.
//  Copyright © 2019 Egor Devyatov. All rights reserved.
//

import UIKit
import Foundation

class ParametersViewController: UIViewController {
    
// MARK: - *** Outlets ***
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
// MARK: - *** Outlets for slider ***
    @IBOutlet weak var elementSizeSlider: UISlider!
    @IBOutlet weak var elementSizeLabel: UILabel!
    
    let defaultValue = "element"
    
// MARK: - *** LiveCicle ***
    override func viewDidLoad() {
        super.viewDidLoad()
        elementSizeLabel.text = "80" //дефолтное значение размера ячеек
    }
    
    // при нажатии на кнопку "Save parameters"
    @IBAction func saveButtonTap(_ sender: UIButton) {
        
        // анимация кнопочки
        sender.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.10),
                       initialSpringVelocity: CGFloat(3.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        })
        
        // если поля ввода новых элементов пустые, то присваиваем им значение по умолчанию - "element"
        sourceData.append(firstTextField.text != "" ? firstTextField.text! : defaultValue)
        sourceData.append(secondTextField.text != "" ? secondTextField.text! : defaultValue)
        sourceData.append(thirdTextField.text != "" ? thirdTextField.text! : defaultValue)
        
        if elementSizeSlider.value != 80 {
            elementSize = Int(elementSizeSlider.value)
        }
    }
    
    // при движении слайдера будем отображать значение слайдера в лейбле elementSizeLabel.text
    @IBAction func sliderTap(_ sender: UISlider) {
        elementSizeLabel.text = String(Int(elementSizeSlider.value))
    }
}

// MARK: - *** Keyboard Autohide using UITextFieldDelegate ***
// реализация автоскрытия (autohide) клавиатуры
extension ParametersViewController: UITextFieldDelegate {
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
