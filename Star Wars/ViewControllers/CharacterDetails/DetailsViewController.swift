//
//  DetailsViewControlle.swift
//  Star Wars
//
//  Created by Victor Hugo Telles on 30/05/19.
//  Copyright © 2019 Victor Hugo Telles. All rights reserved.
//

import UIKit
import FontAwesomeKit
import RealmSwift

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var tableViewDetails: UITableView!
    var character: Character?
    var homeworld: Homeworld? = nil
    var films: [Film] = []
    var species: [Species] = []
    var vehicles: [Vehicle] = []
    var starships: [Starship] = []
    var itemClicked: AnyObject?
    var isFavorite: Bool = false
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationItem.title = character!.name
        self.navigationController?.navigationBar.topItem?.title = "Back";
        self.navigationController?.navigationBar.tintColor = UIColor(
            red: 254/255, green: 196/255, blue: 45/255, alpha: 1
        );
        
        isFavorite = objectExistOnRealm(name: character!.name!)
        updateFavoriteButton(add: false)
        
        self.tableViewDetails.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        self.tableViewDetails.register(UINib.init(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DEFAULT_TABLEVIEWDETAILS_CELL_ID")
    }
    
    func objectExistOnRealm (name: String) -> Bool {
        if (realm.objects(CharacterRealm.self).filter("name = '" + character!.name! + "'").count > 0 ) {
            return true
        } else {
            return false
        }
    }
    
    func updateFavoriteButton(add: Bool) {
        print(isFavorite)
        
        var favAwesome: FAKFontAwesome
        
        if isFavorite {
            favAwesome = FAKFontAwesome.starIcon(withSize: 30.0) as FAKFontAwesome
            
            let character = CharacterRealm()
            character.name = self.character!.name!
            character.height = self.character!.height!
            character.mass = self.character!.mass!
            character.hair_color = self.character!.hair_color!
            character.skin_color = self.character!.skin_color!
            character.eye_color = self.character!.eye_color!
            character.birth_year = self.character!.birth_year!
            character.gender = self.character!.gender!
            character.homeworld = self.character!.homeworld!
            for film in self.character!.films! {
                character.films.append(film)
            }
            for species in self.character!.species! {
                character.species.append(species)
            }
            for vehicle in self.character!.vehicles! {
                character.vehicles.append(vehicle)
            }
            for starship in self.character!.starships! {
                character.starships.append(starship)
            }
            
            if (add) {
                try! realm.write {
                    realm.add(character)
                }
            }
        } else {
            favAwesome = FAKFontAwesome.starOIcon(withSize: 30.0) as FAKFontAwesome
            
            try! realm.write {
                realm.delete(realm.objects(CharacterRealm.self).filter("name = '" + character!.name! + "'"))
            }
        }
        
        favAwesome.addAttribute(NSAttributedString.Key.foregroundColor.rawValue, value: UIColor.white)
        let favBtn = UIButton(type: UIButton.ButtonType.system) as UIButton
        favBtn.frame = CGRect(x: 0,y: 0,width: 30,height: 30)
        favBtn.setImage(favAwesome.image(with: CGSize(width: 30, height: 30)), for: .normal)
        favBtn.addTarget(self, action: #selector(self.didTapFavoriteButton(_:)), for: UIControl.Event.touchUpInside)
        favBtn.tintColor = UIColor(
            red: 254/255, green: 196/255, blue: 45/255, alpha: 1
        );
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favBtn)
    }
    
    @objc func didTapFavoriteButton(_ button:UIBarButtonItem!) {
        isFavorite = !isFavorite
        updateFavoriteButton(add: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = character!.name
    }

}

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate, CollectionViewCellSelectionDelegate {
    
    func performClickOnCVCell(arrayType: Int, index: Int) {
        print("type: \(arrayType), index: \(index)")
        
        switch arrayType {
            case 0: // Homeworld
                self.itemClicked = self.homeworld
            case 1: // Film
                self.itemClicked = films[index]
            case 2: // Species
                self.itemClicked = species[index]
            case 3: // Vehicles
                self.itemClicked = vehicles[index]
            case 4: // Starships
                self.itemClicked = starships[index]
            default:
                self.itemClicked = nil
        }
        
        performSegue(withIdentifier: "DetailToGeneralDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailToGeneralDetail" {
            let vc = segue.destination as! GeneralDetailsViewController
            vc.object = self.itemClicked
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEFAULT_TABLEVIEWDETAILS_CELL_ID") as! DetailTableViewCell
        cell.delegate = self
        
        switch indexPath.row {
            case 0:
                cell.lblType.text = "Height"
                if (Double(self.character!.height!) != nil)  {
                    cell.lblValue.text = "\(Measurement(value: Double(self.character!.height!) as! Double, unit: UnitLength.centimeters).converted(to: UnitLength.meters))"
                } else {
                    cell.lblValue.text = self.character!.height!.capitalized
                }
            case 1:
                cell.lblType.text = "Mass"
                if (Double(self.character!.mass!) != nil) {
                    cell.lblValue.text = self.character!.mass! + " kg"
                } else {
                    cell.lblValue.text = self.character!.mass!.capitalized
                }
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
                if (Int(self.character!.birth_year!.prefix(1)) != nil) {
                    cell.lblValue.text = self.character!.birth_year
                } else {
                    cell.lblValue.text = self.character!.birth_year?.capitalized
                }
            case 6:
                cell.lblType.text = "Gender"
                cell.lblValue.text = self.character!.gender!.capitalized
            case 7:
                cell.lblType.text = "Homeworld"
//                    cell.lblType.isHidden = true
                cell.lblValue.isHidden = true
                
                if self.homeworld == nil {
                    cell.activityIndicator.isHidden = false
                    
                    API.getHomeworldInfo(
                        url: self.character!.homeworld!,
                        success: { (homeworld) in
                            cell.arrayType = 0
                            self.homeworld = homeworld
                            
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
                                    if (!filmsString.contains(title.capitalized)) {
                                        filmsString.append(title.capitalized)
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
                    cell.arrayType = 2
                    cell.lblType.text = "Species"
//                    cell.lblType.isHidden = true
                    cell.lblValue.isHidden = true
                    
                    if (self.species.count == 0) {
                        cell.activityIndicator.isHidden = false
                        let group = DispatchGroup()
                        
                        for speciesUrl in self.character!.species! {
                            group.enter()
                            API.getSpeciesInfo(
                                url: speciesUrl,
                                success: { (species) in
                                    self.species.append(species)
                                    group.leave()
                            },
                                failure: { (error) in print(error)})
                        }
                        
                        group.notify(queue: .main) {
                            var speciesString: [String] = []
                            cell.activityIndicator.isHidden = true
                            
                            for species in self.species {
                                if let name = species.name {
                                    if (!speciesString.contains(name.capitalized)) {
                                        speciesString.append(name.capitalized)
                                    }
                                }
                            }
                            
                            print(speciesString)
                            
                            cell.stringArray = speciesString
                            cell.bgColorForCollectionViewCell = UIColor.purple
                            cell.bgColorForCollectionViewCellLabel = UIColor.white
                            
                            cell.lblType.isHidden = false
                            cell.collectionView.isHidden = false
                            
                            cell.collectionView.reloadData()
                            tableView.reloadData()
                        }
                    }
                } else {
                    cell.lblType.text = "Species"
                    cell.lblValue.text = "N/A"
                }
            case 10:
                if (self.character!.vehicles!.count > 0) {
                    cell.arrayType = 3
                    cell.lblType.text = "Vehicles"
//                    cell.lblType.isHidden = true
                    cell.lblValue.isHidden = true
                    
                    if (self.vehicles.count == 0) {
                        cell.activityIndicator.isHidden = false
                        let group = DispatchGroup()
                        
                        for vehicleUrl in self.character!.vehicles! {
                            group.enter()
                            API.getVehicleInfo(
                                url: vehicleUrl,
                                success: { (vehicle) in
                                    self.vehicles.append(vehicle)
                                    group.leave()
                            },
                                failure: { (error) in print(error)})
                        }
                        
                        group.notify(queue: .main) {
                            var vehiclesString: [String] = []
                            cell.activityIndicator.isHidden = true
                            
                            for vehicle in self.vehicles {
                                if let name = vehicle.name {
                                    if (!vehiclesString.contains(name.capitalized)) {
                                        vehiclesString.append(name.capitalized)
                                    }
                                }
                            }
                            
                            print(vehiclesString)
                            
                            cell.stringArray = vehiclesString
                            cell.bgColorForCollectionViewCell = UIColor.red
                            cell.bgColorForCollectionViewCellLabel = UIColor.white
                            
                            cell.lblType.isHidden = false
                            cell.collectionView.isHidden = false
                            
                            cell.collectionView.reloadData()
                            tableView.reloadData()
                        }
                    }
                } else {
                    cell.lblType.text = "Vehicles"
                    cell.lblValue.text = "N/A"
                }
            case 11:
                if (self.character!.starships!.count > 0) {
                    cell.arrayType = 4
                    cell.lblType.text = "Starships"
//                    cell.lblType.isHidden = true
                    cell.lblValue.isHidden = true
                    
                    if (self.starships.count == 0) {
                        cell.activityIndicator.isHidden = false
                        let group = DispatchGroup()
                        
                        for starshipUrl in self.character!.starships! {
                            group.enter()
                            API.getStarshipInfo(
                                url: starshipUrl,
                                success: { (starship) in
                                    self.starships.append(starship)
                                    group.leave()
                            },
                                failure: { (error) in print(error)})
                        }
                        
                        group.notify(queue: .main) {
                            var starshipsString: [String] = []
                            cell.activityIndicator.isHidden = true
                            
                            for starship in self.starships {
                                if let name = starship.name {
                                    if (!starshipsString.contains(name.capitalized)) {
                                        starshipsString.append(name.capitalized)
                                    }
                                }
                            }
                            
                            print(starshipsString)
                            
                            cell.stringArray = starshipsString
                            cell.bgColorForCollectionViewCell = UIColor.blue
                            cell.bgColorForCollectionViewCellLabel = UIColor.white
                            
                            cell.lblType.isHidden = false
                            cell.collectionView.isHidden = false
                            
                            cell.collectionView.reloadData()
                            tableView.reloadData()
                        }
                    }
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
