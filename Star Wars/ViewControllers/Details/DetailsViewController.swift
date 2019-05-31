//
//  DetailsViewControlle.swift
//  Star Wars
//
//  Created by Victor Hugo Telles on 30/05/19.
//  Copyright © 2019 Victor Hugo Telles. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var tableViewDetails: UITableView!
    var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationItem.title = character!.name
        
        self.tableViewDetails.register(UINib.init(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DEFAULT_TABLEVIEWDETAILS_CELL_ID")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }

}

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        name, height, mass, hairColor: String?
//        skinColor: String?
//        eyeColor: String?
//        birthYear: String?
//        gender: String?
//        homeworld: String?
//        films, species, vehicles, starships: [String]?
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEFAULT_TABLEVIEWDETAILS_CELL_ID") as! DetailTableViewCell
        
        switch indexPath.row {
            case 0:
                cell.lblType.text = "Height"
                cell.lblValue.text = "\(Measurement(value: Double(self.character!.height!) as! Double, unit: UnitLength.centimeters).converted(to: UnitLength.meters))"
            case 1:
                cell.lblType.text = "Mass"
                cell.lblValue.text = self.character!.mass! + " kg"
            case 2:
                cell.lblType.text = "Hair Color"
                cell.lblValue.text = self.character!.hair_color!.capitalized
            case 3:
                cell.lblType.text = "Skin Color"
                cell.lblValue.text = self.character!.skin_color!.capitalized
            case 4:
                cell.lblType.text = "Eye Color"
                cell.lblValue.text = self.character!.eye_color!.capitalized
            case 5:
                cell.lblType.text = "Birth Year"
                cell.lblValue.text = self.character!.birth_year
            case 6:
                cell.lblType.text = "Gender"
                cell.lblValue.text = self.character!.gender!.capitalized
            case 7:
                cell.lblType.text = "Homeworld"
                cell.lblValue.text = self.character?.homeworld
            case 8:
                cell.lblType.text = "Films"
                cell.lblValue.text = "COLLECTION"
            case 9:
                cell.lblType.text = "Species"
                cell.lblValue.text = "COLLECTION"
            case 10:
                cell.lblType.text = "Vehicles"
                cell.lblValue.text = "COLLECTION"
            case 11:
                cell.lblType.text = "Starships"
                cell.lblValue.text = "COLLECTION"
            default:
                cell.lblType.text = ""
                cell.lblValue.text = ""
        }
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
