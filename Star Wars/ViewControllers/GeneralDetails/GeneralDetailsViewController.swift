//
//  DetailsViewControlle.swift
//  Star Wars
//
//  Created by Victor Hugo Telles on 30/05/19.
//  Copyright © 2019 Victor Hugo Telles. All rights reserved.
//

import UIKit

class GeneralDetailsViewController: UIViewController {
 
    var object: AnyObject?
    @IBOutlet weak var tableViewGeneralDetails: UITableView!
    
    var residents: [Character] = []
    var films: [Film] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.topItem?.title = "";
        
        if let homeworld = object as? Homeworld {
            navigationItem.title = homeworld.name
        } else if let film = object as? Film {
            navigationItem.title = film.title
        } else if let species = object as? Species {
            navigationItem.title = species.name
        } else if let vehicle = object as? Vehicle {
            navigationItem.title = vehicle.name
        } else if let starship = object as? Starship {
            navigationItem.title = starship.name
        }
        
        self.tableViewGeneralDetails.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        self.tableViewGeneralDetails.register(UINib.init(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID")
        
    }

}

extension GeneralDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (object as? Homeworld) != nil {
//            rotation_period, orbital_period, diameter: String?
//            climate, gravity, terrain, surface_water: String?
//            population: String?
//            residents, films: [String]?
            return 10
        } else if (object as? Film) != nil {
//            episode_id: Int?
//            opening_crawl, director, producer, release_date: String?
//            characters, planets, starships, vehicles: [String]?
//            species: [String]?
            return 10
        } else if (object as? Species) != nil {
//            classification, designation, average_height: String?
//            skin_colors, hair_colors, eye_colors, average_lifespan: String?
//            homeworld: String?
//            language: String?
//            people, films: [String]?
            return 11
        } else if (object as? Vehicle) != nil {
//            model, manufacturer, cost_in_credits: String?
//            length, max_atmosphering_speed, crew, passengers: String?
//            cargo_capacity, consumables, vehicle_class: String?
//            pilots, films: [String]?
            return 12
        } else if (object as? Starship) != nil {
//            model, manufacturer, cost_in_credits: String?
//            length, max_atmosphering_speed, crew, passengers: String?
//            cargo_capacity, consumables, hyperdrive_rating, MGLT: String?
//            starship_class: String?
//            pilots, films: [String]?
            return 14
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID") as! DetailTableViewCell
        
        if let homeworld = object as? Homeworld {
            switch indexPath.row {
                case 0:
                    cell.lblType.text = "Rotation Period"
                    if (Int(homeworld.rotation_period!) != nil) {
                        cell.lblValue.text = homeworld.rotation_period! + " hours"
                    } else {
                        cell.lblValue.text = homeworld.rotation_period!.capitalized
                    }
                case 1:
                    cell.lblType.text = "Orbital Period"
                    if (Int(homeworld.orbital_period!) != nil) {
                        cell.lblValue.text = homeworld.orbital_period! + " days"
                    } else {
                        cell.lblValue.text = homeworld.orbital_period!.capitalized
                    }
                case 2:
                    cell.lblType.text = "Diameter"
                    if (Int(homeworld.diameter!) != nil) {
                        cell.lblValue.text = formatInt(inputNumber: homeworld.diameter!) + " km"
                    } else {
                        cell.lblValue.text = homeworld.diameter!.capitalized
                    }
                case 3:
                    cell.lblType.text = "Climate"
                    cell.lblValue.text = homeworld.climate?.capitalized
                case 4:
                    cell.lblType.text = "Gravity"
                    cell.lblValue.text = homeworld.gravity?.capitalized
                case 5:
                    cell.lblType.text = "Terrain"
                    cell.lblValue.text = homeworld.terrain?.capitalized
                case 6:
                    cell.lblType.text = "Surface Water"
                    if (Int(homeworld.surface_water!) != nil) {
                        cell.lblValue.text = homeworld.surface_water! + "%"
                    } else {
                        cell.lblValue.text = homeworld.surface_water!.capitalized
                    }
                case 7:
                    cell.lblType.text = "Population"
                    if (Int(homeworld.population!) != nil) {
                        cell.lblValue.text = formatInt(inputNumber: homeworld.population!)
                    } else {
                        cell.lblValue.text = homeworld.population!.capitalized
                    }
                case 8:
                    cell.lblType.text = "Residents"
                    cell.lblValue.isHidden = true
                
                    if (self.residents.count == 0) {
                        cell.activityIndicator.isHidden = false
                        let group = DispatchGroup()
                        
                        for residentUrl in homeworld.residents! {
                            group.enter()
                            API.getCharacterInfo(
                                url: residentUrl,
                                success: { (character) in
                                    self.residents.append(character)
                                    group.leave()
                            },
                                failure: { (error) in print(error)})
                        }
                        
                        group.notify(queue: .main) {
                            var charactersString: [String] = []
                            cell.activityIndicator.isHidden = true
                            
                            for resident in self.residents {
                                if let name = resident.name {
                                    if (!charactersString.contains(name)) {
                                        charactersString.append(name)
                                    }
                                }
                            }
                            
                            print(charactersString)
                            
                            cell.stringArray = charactersString
                            cell.bgColorForCollectionViewCell = UIColor.orange
                            cell.bgColorForCollectionViewCellLabel = UIColor.white
                            
                            cell.lblType.isHidden = false
                            cell.collectionView.isHidden = false
                            
                            cell.collectionView.reloadData()
                            tableView.reloadData()
                        }
                    } else {
                        cell.lblType.text = "Residents"
                        cell.lblValue.text = "N/A"
                    }
                case 9:
                    cell.lblType.text = "Films"
                    cell.lblValue.isHidden = true
                    
                    if (self.films.count == 0) {
                        cell.activityIndicator.isHidden = false
                        let group = DispatchGroup()
                        
                        for filmUrl in homeworld.films! {
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
                    } else {
                        cell.lblType.text = "Films"
                        cell.lblValue.text = "N/A"
                    }
                default:
                    cell.lblType.text = ""
                    cell.lblValue.text = ""
            }
        } else if let film = object as? Film {
            switch indexPath.row {
                case 0:
                    cell.lblType.text = "Episode ID"
                    cell.lblValue.text = String(film.episode_id!)
                case 1:
                    cell.lblType.text = "Opening Crawl"
                    cell.lblValue.text = film.opening_crawl
                case 2:
                    cell.lblType.text = "Director"
                    cell.lblValue.text = film.director
                case 3:
                    cell.lblType.text = "Producer"
                    cell.lblValue.text = film.producer
                case 4:
                    cell.lblType.text = "Release Date"
                    cell.lblValue.text = film.release_date
                case 5:
                    cell.lblType.text = "Characters"
                    cell.lblValue.text = "COLLECTION"
                case 6:
                    cell.lblType.text = "Planets"
                    cell.lblValue.text = "COLLECTION"
                case 7:
                    cell.lblType.text = "Starships"
                    cell.lblValue.text = "COLLECTION"
                case 8:
                    cell.lblType.text = "Vehicles"
                    cell.lblValue.text = "COLLECTION"
                case 9:
                    cell.lblType.text = "Species"
                    cell.lblValue.text = "COLLECTION"
                default:
                    cell.lblType.text = ""
                    cell.lblValue.text = ""
            }
        } else if let species = object as? Species {
            switch indexPath.row {
                case 0:
                    cell.lblType.text = "Classification"
                    cell.lblValue.text = species.classification
                case 1:
                    cell.lblType.text = "Designation"
                    cell.lblValue.text = species.designation
                case 2:
                    cell.lblType.text = "Average Height"
                    cell.lblValue.text = species.average_height
                case 3:
                    cell.lblType.text = "Skin Colors"
                    cell.lblValue.text = species.skin_colors
                case 4:
                    cell.lblType.text = "Hair Colors"
                    cell.lblValue.text = species.hair_colors
                case 5:
                    cell.lblType.text = "Eye Colors"
                    cell.lblValue.text = species.eye_colors
                case 6:
                    cell.lblType.text = "Average Lifespan"
                    cell.lblValue.text = species.average_lifespan
                case 7:
                    cell.lblType.text = "Homeworld"
                    cell.lblValue.text = species.homeworld
                case 8:
                    cell.lblType.text = "Language"
                    cell.lblValue.text = species.language
                case 9:
                    cell.lblType.text = "People"
                    cell.lblValue.text = "COLLECTION"
                case 10:
                    cell.lblType.text = "Films"
                    cell.lblValue.text = "COLLECTION"
                default:
                    cell.lblType.text = ""
                    cell.lblValue.text = ""
            }
        } else if let vehicle = object as? Vehicle {
            switch indexPath.row {
                case 0:
                    cell.lblType.text = "Model"
                    cell.lblValue.text = vehicle.model
                case 1:
                    cell.lblType.text = "Manufacturer"
                    cell.lblValue.text = vehicle.manufacturer
                case 2:
                    cell.lblType.text = "Cost (In Credits)"
                    cell.lblValue.text = vehicle.cost_in_credits
                case 3:
                    cell.lblType.text = "Length"
                    cell.lblValue.text = vehicle.length
                case 4:
                    cell.lblType.text = "Maximum Atmosphering Speed"
                    cell.lblValue.text = vehicle.max_atmosphering_speed
                case 5:
                    cell.lblType.text = "Crew"
                    cell.lblValue.text = vehicle.crew
                case 6:
                    cell.lblType.text = "Passengers"
                    cell.lblValue.text = vehicle.passengers
                case 7:
                    cell.lblType.text = "Cargo Capacity"
                    cell.lblValue.text = vehicle.cargo_capacity
                case 8:
                    cell.lblType.text = "Consumables"
                    cell.lblValue.text = vehicle.consumables
                case 9:
                    cell.lblType.text = "Vehicle Class"
                    cell.lblValue.text = vehicle.vehicle_class
                case 10:
                    cell.lblType.text = "Pilots"
                    cell.lblValue.text = "COLLECTION"
                case 11:
                    cell.lblType.text = "Films"
                    cell.lblValue.text = "COLLECTION"
                default:
                    cell.lblType.text = ""
                    cell.lblValue.text = ""
            }
        } else if let starship = object as? Starship {
            switch indexPath.row {
                case 0:
                    cell.lblType.text = "Model"
                    cell.lblValue.text = starship.model
                case 1:
                    cell.lblType.text = "Manufacturer"
                    cell.lblValue.text = starship.manufacturer
                case 2:
                    cell.lblType.text = "Cost (In Credits)"
                    cell.lblValue.text = starship.cost_in_credits
                case 3:
                    cell.lblType.text = "Length"
                    cell.lblValue.text = starship.length
                case 4:
                    cell.lblType.text = "Maximum Atmosphering Speed"
                    cell.lblValue.text = starship.max_atmosphering_speed
                case 5:
                    cell.lblType.text = "Crew"
                    cell.lblValue.text = starship.crew
                case 6:
                    cell.lblType.text = "Passengers"
                    cell.lblValue.text = starship.passengers
                case 7:
                    cell.lblType.text = "Cargo Capacity"
                    cell.lblValue.text = starship.cargo_capacity
                case 8:
                    cell.lblType.text = "Consumables"
                    cell.lblValue.text = starship.consumables
                case 9:
                    cell.lblType.text = "Hyperdrive Rating"
                    cell.lblValue.text = starship.hyperdrive_rating
                case 10:
                    cell.lblType.text = "Megalight Per Hour"
                    cell.lblValue.text = starship.MGLT
                case 11:
                    cell.lblType.text = "Starships Class"
                    cell.lblValue.text = starship.starship_class
                case 12:
                    cell.lblType.text = "Pilots"
                    cell.lblValue.text = "COLLECTION"
                case 13:
                    cell.lblType.text = "Films"
                    cell.lblValue.text = "COLLECTION"
                default:
                    cell.lblType.text = ""
                    cell.lblValue.text = ""
            }
        }
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func formatInt(inputNumber: String) -> String {
        var count: Int = inputNumber.count
        var newInt = inputNumber
        while count >= 4 {
            count = count - 3
            newInt.insert(".", at: newInt.index(newInt.startIndex, offsetBy: count))
        }
        return "\(newInt)"
    }
    
}
