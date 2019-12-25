//
//  MainTableViewController.swift
//  CarAccountingApp
//
//  Created by Элла Чурсина on 23.12.2019.
//  Copyright © 2019 Элла Чурсина. All rights reserved.
//

import UIKit

class MainTableViewController: UIViewController, AddNewCarViewControllerDelegate {
    
    var model = CarModel()
    let idCell = "CarCell"
    
    @IBOutlet weak var accountingCarTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountingCarTableView.dataSource = self
        accountingCarTableView.delegate = self
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let addNewCar = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(goToAddingNewCar))
        navigationItem.rightBarButtonItem = addNewCar
        //accountingCarTableView.isEditing = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        
    }
    @objc func goToAddingNewCar() {
        let vc = storyboard?.instantiateViewController(identifier: "AddNewCarViewController") as! AddNewCarViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.delegate = self
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteSwipe = UIContextualAction(style: .normal, title: "Delete") { (action, view, success) in
            self.accountingCarTableView.performBatchUpdates({
                self.model.deleteCar(indexPath: indexPath)
                self.accountingCarTableView.deleteRows(at:  [indexPath], with: .automatic)
                success(true)
            }, completion: nil)
        }
        deleteSwipe.backgroundColor = .red
        deleteSwipe.image = UIImage(named: "delete")
        return UISwipeActionsConfiguration(actions: [deleteSwipe])
    }
    
    
    func addNewCarViewController(_ AddNewCarViewController: AddNewCarViewController, didAddNewCar newCar: Car){
        model.cars.append(newCar)
        accountingCarTableView.reloadData()
    }
    


}
extension MainTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: idCell)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: idCell)
        }
        let car = model.cars[indexPath.row]
        cell!.textLabel?.text = "\(car.manufacturingCompany) \(car.model)"
        cell!.imageView?.image = UIImage(named: "car")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "SelectedCarViewController") as! SelectedCarViewController
        let editingVC = storyboard?.instantiateViewController(identifier: "EditingCarViewController") as! EditingCarViewController
        let car = model.cars[indexPath.row]
        vc.receivedTitle  = "\(car.manufacturingCompany) \(car.model)"
        vc.receivedDescription = "The year of issue is \(car.yearOfIssue). The car's body type is a \(car.bodyType)"
        editingVC.receivedManufacturingCompany = "\(car.manufacturingCompany)"
        editingVC.receivedModel = "\(car.model)"
        editingVC.receivedYearOfIssue = "\(car.yearOfIssue)"
        self.navigationController?.pushViewController(vc, animated: true)
        print(indexPath.row)
    }
        
    }
