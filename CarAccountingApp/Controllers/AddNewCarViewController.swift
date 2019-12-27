//
//  AddNewCarViewController.swift
//  CarAccountingApp
//
//  Created by Элла Чурсина on 24.12.2019.
//  Copyright © 2019 Элла Чурсина. All rights reserved.
//

import UIKit
import CoreData



class AddNewCarViewController: UIViewController {
    
    var selectedBodyType : String?
    

    @IBOutlet weak var manufacturingCompanyTextField: UITextField!
    
    @IBOutlet weak var modelTextField: UITextField!
    
    @IBOutlet weak var yearOfIssueTextField: UITextField!
    
    @IBOutlet var bodyTypePickerView: UIPickerView!
    
   
    
    
    
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
        let bodyType = selectedBodyType
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newCar = Car(context: context)
        newCar.manufacturingCompany = manufacturingCompany
        newCar.model = modelCar
        newCar.yearOfIssue = Int32(yearOfIssue!)
        newCar.bodyType = bodyType
        newCar.idCar = UUID().uuidString
        do {
            try context.save()
        } catch let error {
            print("Failed to save due to error \(error).")
        }
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
