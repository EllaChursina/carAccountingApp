//
//  EditingCarViewController.swift
//  CarAccountingApp
//
//  Created by Элла Чурсина on 25.12.2019.
//  Copyright © 2019 Элла Чурсина. All rights reserved.
//

import UIKit
import CoreData

class EditingCarViewController: UIViewController {
    
    var selectedBodyType : String?
    var manufacturingCompanyDefaultText = ""
    var modelDefaultText = ""
    var yearOfIssueDefaultText = ""
    var selectedCarID = ""
    
    @IBOutlet weak var manufacturingCompanyTextField: UITextField!
    
    @IBOutlet weak var modelTextField: UITextField!
    
    
    @IBOutlet weak var yearOfIssueTextField: UITextField!
    
    @IBOutlet var bodyTypeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        let saveNewCar = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        navigationItem.rightBarButtonItem = saveNewCar
        createBodyTypePickerView()
        manufacturingCompanyTextField.text = manufacturingCompanyDefaultText
        modelTextField.text = modelDefaultText
        yearOfIssueTextField.text = yearOfIssueDefaultText
        bodyTypeTextField.text = selectedBodyType
       
        
        // Do any additional setup after loading the view.
    }
    func createBodyTypePickerView(){
        
      let bodyTypePickerView = UIPickerView()
      bodyTypePickerView.delegate = self
        
      bodyTypeTextField.inputView = bodyTypePickerView
        
    }
    @objc func saveTapped() {
        let manufacturingCompany = manufacturingCompanyTextField.text ?? ""
        let modelCar = modelTextField.text ?? ""
        let yearOfIssue = Int(yearOfIssueTextField.text ?? "0")
        let bodyType = selectedBodyType
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = Car.fetchRequest() as NSFetchRequest<Car>
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results {
                    if result.idCar == selectedCarID {
                        result.manufacturingCompany = manufacturingCompany
                        result.model = modelCar
                        result.yearOfIssue = Int32(yearOfIssue!)
                        result.bodyType = bodyType
                    }
                }
            }
        } catch let error {
            print("Failed to save due to error \(error).")
        }
            
        do {
            try context.save()
        } catch let error {
            print("Failed to save due to error \(error).")
        }
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
            let value = CarBodyType.allCases[row].rawValue
            selectedBodyType = value
            bodyTypeTextField.text = selectedBodyType
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


