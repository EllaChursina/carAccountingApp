//
//  AddNewCarViewController.swift
//  CarAccountingApp
//
//  Created by Элла Чурсина on 24.12.2019.
//  Copyright © 2019 Элла Чурсина. All rights reserved.
//

import UIKit
import CoreData

protocol AddNewCarViewControllerDelegate {
    func addNewCarViewController(_ AddNewCarViewController: AddNewCarViewController, didAddNewCar newCar: Car)
}

class AddNewCarViewController: UIViewController {
    
    var selectedBodyType = CarBodyType.allCases[0].rawValue 

    @IBOutlet weak var manufacturingCompanyTextField: UITextField!
    
    @IBOutlet weak var modelTextField: UITextField!
    
    @IBOutlet weak var yearOfIssueTextField: UITextField!
    
    @IBOutlet var bodyTypePickerView: UIPickerView!
    
    var delegate: AddNewCarViewControllerDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        bodyTypePickerView.dataSource = self
        bodyTypePickerView.delegate = self
        let saveNewCar = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        navigationItem.rightBarButtonItem = saveNewCar
        // Do any additional setup after loading the view.
    }
    
    @objc func saveTapped() {
        let manufacturingCompany = manufacturingCompanyTextField.text ?? ""
        let modelCar = modelTextField.text ?? ""
        let yearOfIssue = Int(yearOfIssueTextField.text ?? "0")
        let bodyType = CarBodyType(rawValue: selectedBodyType)
        let newCar = Car(yearOfIssue: yearOfIssue!, manufacturingCompany: manufacturingCompany, model: modelCar, bodyType: bodyType!)
        delegate?.addNewCarViewController(self, didAddNewCar: newCar)
        //let vc = storyboard?.instantiateViewController(identifier: "MainTableViewController") as! MainTableViewController
        //self.navigationController?.pushViewController(vc, animated: true)
    }


}
extension AddNewCarViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CarBodyType.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CarBodyType.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedBodyType = CarBodyType.allCases[row].rawValue
   }
}
