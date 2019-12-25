//
//  EditingCarViewController.swift
//  CarAccountingApp
//
//  Created by Элла Чурсина on 25.12.2019.
//  Copyright © 2019 Элла Чурсина. All rights reserved.
//

import UIKit

class EditingCarViewController: UIViewController {
    
    
    @IBOutlet weak var manufacturingCompanyTextField: UITextField!
    
    @IBOutlet weak var modelTextField: UITextField!
    
    
    @IBOutlet weak var yearOfIssueTextField: UITextField!
    
    
    @IBOutlet weak var bodyTypePickerView: UIPickerView!
    
    var receivedManufacturingCompany = "1"
    
    var receivedModel = "1"
    
    var receivedYearOfIssue = "1"
    
    var receivedBodyType = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        bodyTypePickerView.dataSource = self
        bodyTypePickerView.delegate = self
        let saveNewCar = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        navigationItem.rightBarButtonItem = saveNewCar
        manufacturingCompanyTextField.text = receivedManufacturingCompany
        modelTextField.text = receivedModel
        yearOfIssueTextField.text = receivedYearOfIssue
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func saveTapped() {
        let manufacturingCompany = manufacturingCompanyTextField.text ?? ""
        let modelCar = modelTextField.text ?? ""
        let yearOfIssue = Int(yearOfIssueTextField.text ?? "0")
        //let bodyType = CarBodyType(rawValue: selectedBodyType)
        //let newCar = Car(yearOfIssue: yearOfIssue!, manufacturingCompany: manufacturingCompany, model: modelCar, bodyType: bodyType!)
        //delegate?.addNewCarViewController(self, didAddNewCar: newCar)

    }


    }
    extension EditingCarViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
            receivedBodyType = CarBodyType.allCases[row].rawValue
       }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


