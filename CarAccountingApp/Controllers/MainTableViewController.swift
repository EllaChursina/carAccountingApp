//
//  MainTableViewController.swift
//  CarAccountingApp
//
//  Created by Элла Чурсина on 23.12.2019.
//  Copyright © 2019 Элла Чурсина. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UIViewController {
    
    var cars = [Car]()
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = Car.fetchRequest() as NSFetchRequest<Car>
        do {
            cars = try context.fetch(fetchRequest)
        } catch let error {
            print("Failed to save due to error \(error).")
        }
        accountingCarTableView.reloadData()
        
        
    }
    @objc func goToAddingNewCar() {
        let vc = storyboard?.instantiateViewController(identifier: "AddNewCarViewController") as! AddNewCarViewController
        self.navigationController?.pushViewController(vc, animated: true)
       
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteSwipe = UIContextualAction(style: .normal, title: "Delete") { (action, view, success) in
            self.accountingCarTableView.performBatchUpdates({
                //self.model.deleteCar(indexPath: indexPath)
                self.accountingCarTableView.deleteRows(at:  [indexPath], with: .automatic)
                success(true)
            }, completion: nil)
        }
        deleteSwipe.backgroundColor = .red
        deleteSwipe.image = UIImage(named: "delete")
        return UISwipeActionsConfiguration(actions: [deleteSwipe])
    }
    
    


}
extension MainTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: idCell)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: idCell)
        }
        let car = cars[indexPath.row]
        let manufacturingCompany = car.manufacturingCompany ?? ""
        let model = car.model ?? ""
        cell!.textLabel?.text = "\(manufacturingCompany) \(model)"
        cell!.imageView?.image = UIImage(named: "car")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "SelectedCarViewController") as! SelectedCarViewController
        let car = cars[indexPath.row]
        let manufacturingCompany = car.manufacturingCompany ?? ""
        let model = car.model ?? ""
        var yearOfIssue : String
        if let checkYearOfIssue = car.yearOfIssue as Int32? {
            yearOfIssue = String(car.yearOfIssue)
        } else {
            yearOfIssue = " "
        }
        let bodyType = car.bodyType ?? ""
        vc.receivedTitle  = "\(manufacturingCompany) \(model)"
        vc.receivedDescription = "The year of issue is \(yearOfIssue). The car's body type is a \(bodyType)"
        self.navigationController?.pushViewController(vc, animated: true)
        print(indexPath.row)
    }
        
    }
