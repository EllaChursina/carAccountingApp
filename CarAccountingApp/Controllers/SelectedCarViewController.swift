//
//  SelectedCarViewController.swift
//  CarAccountingApp
//
//  Created by Элла Чурсина on 19.12.2019.
//  Copyright © 2019 Элла Чурсина. All rights reserved.
//

import UIKit

class SelectedCarViewController: UIViewController {

    @IBOutlet weak var selectedCarTitle: UILabel!
    @IBOutlet weak var selectedCarDescription: UILabel!
    
    var receivedTitle = ""
    var receivedDescription = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        selectedCarTitle.text = receivedTitle
        selectedCarDescription.text = receivedDescription
        let editCar = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(goToEditing))
        navigationItem.rightBarButtonItem = editCar
       
    }
    
    @objc func goToEditing() {
        
        let vc = storyboard?.instantiateViewController(identifier: "EditingCarViewController") as! EditingCarViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
      }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
