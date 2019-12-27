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
    //код удаления без save
    /*func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if cars.count > indexPath.row {
            let car = cars[indexPath.row]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        context.delete(car)
        cars.remove(at: indexPath.row)
        accountingCarTableView.deleteRows(at:  [indexPath], with: .fade)
        }
        
    }*/
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteSwipe = UIContextualAction(style: .normal, title: "Delete") { (action, view, success) in
            self.accountingCarTableView.performBatchUpdates({
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let car = self.cars[indexPath.row]
                context.delete(car)
                self.cars.remove(at: indexPath.row)
                do{
                    try context.save()
                } catch let error{
                    print("Failed to save due to error \(error).")
                }
                self.accountingCarTableView.deleteRows(at:  [indexPath], with: .automatic)
                self.accountingCarTableView.reloadData()
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
        let vc = storyboard?.instantiateViewController(identifier: "EditingCarViewController") as! EditingCarViewController
        let car = cars[indexPath.row]
        let manufacturingCompany = car.manufacturingCompany ?? ""
        let model = car.model ?? ""
        var yearOfIssue : String
        if (car.yearOfIssue as Int32?) != nil {
            yearOfIssue = String(car.yearOfIssue)
        } else {
            yearOfIssue = " "
        }
        let idCar = car.idCar ?? ""
        let bodyType = car.bodyType ?? ""
        vc.manufacturingCompanyDefaultText = manufacturingCompany
        vc.modelDefaultText = model
        vc.yearOfIssueDefaultText = yearOfIssue
        vc.selectedBodyType = bodyType
        vc.selectedCarID = idCar
        self.navigationController?.pushViewController(vc, animated: true)
        print(bodyType)
    }
        
    }
