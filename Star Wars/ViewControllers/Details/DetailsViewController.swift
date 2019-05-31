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
    var films: [Film] = []
//    var species: [Species] = []
//    var vehicles: [Vehicle] = []
//    var starships: [Starships] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationItem.title = character!.name
        
        self.tableViewDetails.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
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
                cell.lblValue.isHidden = true
                if (self.character!.homeworld!.contains("https://")) {
                    cell.activityIndicator.isHidden = false
                    cell.lblType.isHidden = true
                    
                    API.getHomeworldInfo(
                        url: self.character!.homeworld!,
                        success: { (homeworld) in
                            cell.arrayType = 0
                            self.character?.homeworld = homeworld.name
                            
                            cell.stringArray = [homeworld.name!.capitalized]
                            
                            if (homeworld.name!.elementsEqual("unknown")) {
                                cell.bgColorForCollectionViewCell = UIColor.black
                            } else {
                                cell.bgColorForCollectionViewCell = UIColor(red: 0, green: 140/255, blue: 25/255, alpha: 1)
                            }
                            cell.bgColorForCollectionViewCellLabel = UIColor.white
                            
                            cell.activityIndicator.isHidden = true
                            
                            cell.lblType.isHidden = false
                            cell.collectionView.isHidden = false
                            
                            cell.collectionView.reloadData()
                            tableView.reloadData()
                    },
                        failure: { (error) in print(error)})
                }
            case 8:
                if (self.character!.films!.count > 0) {
                    cell.arrayType = 1
                    cell.lblType.text = "Films"
//                    cell.lblType.isHidden = true
                    cell.lblValue.isHidden = true
                    
                    if (self.films.count == 0) {
                        cell.activityIndicator.isHidden = false
                        let group = DispatchGroup()
                        
                        for filmUrl in self.character!.films! {
                            group.enter()
                            API.getFilmInfo(
                                url: filmUrl,
                                success: { (film) in
                                    self.films.append(film)
                                group.leave()
                            },
                                failure: { (error) in print(error)})
                        }
                        
                        group.notify(queue: .main) {
                            var filmsString: [String] = []
                            cell.activityIndicator.isHidden = true
                            
                            for film in self.films {
                                if let title = film.title {
                                    if (!filmsString.contains(title)) {
                                        filmsString.append(title)
                                    }
                                }
                            }
                            
                            print(filmsString)
                            
                            cell.stringArray = filmsString
                            cell.bgColorForCollectionViewCell = UIColor.brown
                            cell.bgColorForCollectionViewCellLabel = UIColor.white
                            
                            cell.lblType.isHidden = false
                            cell.collectionView.isHidden = false
                            
                            cell.collectionView.reloadData()
                            tableView.reloadData()
                        }
                    }
                } else {
                    cell.lblType.text = "Films"
                    cell.lblValue.text = "N/A"
                }
            case 9:
                if (self.character!.species!.count > 0) {
                    cell.lblType.text = "Species"
                    cell.lblValue.text = "COLLECTION"
                } else {
                    cell.lblType.text = "Species"
                    cell.lblValue.text = "N/A"
                }
            case 10:
                if (self.character!.vehicles!.count > 0) {
                    cell.lblType.text = "Vehicles"
                    cell.lblValue.text = "COLLECTION"
                } else {
                    cell.lblType.text = "Vehicles"
                    cell.lblValue.text = "N/A"
                }
            case 11:
                if (self.character!.starships!.count > 0) {
                    cell.lblType.text = "Starships"
                    cell.lblValue.text = "COLLECTION"
                } else {
                    cell.lblType.text = "Starships"
                    cell.lblValue.text = "N/A"
                }
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
