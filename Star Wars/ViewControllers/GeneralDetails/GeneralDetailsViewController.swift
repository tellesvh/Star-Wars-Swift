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
    
    var characters: [Character] = []
    var films: [Film] = []
    var planets: [Homeworld] = []
    var starships: [Starship] = []
    var vehicles: [Vehicle] = []
    var species: [Species] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationController?.navigationBar.topItem?.title = "";
        
        if let homeworld = object as? Homeworld {
            navigationItem.title = homeworld.name?.capitalized
        } else if let film = object as? Film {
            navigationItem.title = film.title?.capitalized
        } else if let species = object as? Species {
            navigationItem.title = species.name?.capitalized
        } else if let vehicle = object as? Vehicle {
            navigationItem.title = vehicle.name?.capitalized
        } else if let starship = object as? Starship {
            navigationItem.title = starship.name?.capitalized
        }
        
        self.tableViewGeneralDetails.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        self.tableViewGeneralDetails.register(UINib.init(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_NORMAL")
        self.tableViewGeneralDetails.register(UINib.init(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_COLLECTION-FILMS")
        self.tableViewGeneralDetails.register(UINib.init(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_COLLECTION-CHARACTERS")
        self.tableViewGeneralDetails.register(UINib.init(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_COLLECTION-PLANETS")
        self.tableViewGeneralDetails.register(UINib.init(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_COLLECTION-STARSHIPS")
        self.tableViewGeneralDetails.register(UINib.init(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_COLLECTION-VEHICLES")
        self.tableViewGeneralDetails.register(UINib.init(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_COLLECTION-SPECIES")
        
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
        var cell = tableView.dequeueReusableCell(withIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_NORMAL") as! DetailTableViewCell
        
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
                    cell = tableView.dequeueReusableCell(withIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_COLLECTION-CHARACTERS") as! DetailTableViewCell
                    if (homeworld.residents!.count > 0) {
                        cell.lblType.text = "Residents"
                        cell.lblValue.isHidden = true
                    
                        if (self.characters.count == 0) {
                            cell.activityIndicator.isHidden = false
                            let group = DispatchGroup()
                            
                            for residentUrl in homeworld.residents! {
                                group.enter()
                                API.getCharacterInfo(
                                    url: residentUrl,
                                    success: { (character) in
                                        self.characters.append(character)
                                        group.leave()
                                },
                                    failure: { (error) in print(error)})
                            }
                            
                            group.notify(queue: .main) {
                                var charactersString: [String] = []
                                cell.activityIndicator.isHidden = true
                                
                                for resident in self.characters {
                                    if let name = resident.name {
                                        if (!charactersString.contains(name)) {
                                            charactersString.append(name)
                                        }
                                    }
                                }
                                
                                print(charactersString)
                                
                                cell.stringArray = charactersString
                                cell.bgColorForCollectionViewCell = UIColor.orange
                                cell.bgColorForCollectionViewCellLabel = UIColor.black
                                cell.isBackgroundClear = true
                                
                                cell.lblType.isHidden = false
                                cell.collectionView.isHidden = false
                                
                                cell.collectionView.reloadData()
                                tableView.reloadData()
                            }
                        }
                    } else {
                        cell.lblType.text = "Residents"
                        cell.lblValue.text = "N/A"
                    }
                case 9:
                    cell = tableView.dequeueReusableCell(withIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_COLLECTION-FILMS") as! DetailTableViewCell
                    if (homeworld.films!.count > 0) {
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
                                        if (!filmsString.contains(title.capitalized)) {
                                            filmsString.append(title.capitalized)
                                        }
                                    }
                                }
                                
                                print(filmsString)
                                
                                cell.stringArray = filmsString
                                cell.bgColorForCollectionViewCell = UIColor.brown
                                cell.bgColorForCollectionViewCellLabel = UIColor.black
                                cell.isBackgroundClear = true
                                
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
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "YYYY-MM-dd"
                    if let date = dateFormatter.date(from: film.release_date!) {
                        dateFormatter.dateFormat = "MMM dd, yyyy"
                        dateFormatter.locale =  NSLocale(localeIdentifier: "en_US_POSIX") as Locale
                        cell.lblValue.text = dateFormatter.string(from: date)
                    }
                case 5:
                    cell = tableView.dequeueReusableCell(withIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_COLLECTION-CHARACTERS") as! DetailTableViewCell
                    cell.lblType.text = "Characters"
                    
                    if (film.characters!.count > 0) {
                        cell.lblValue.isHidden = true
                        
                        if (self.characters.count == 0) {
                            cell.activityIndicator.isHidden = false
                            let group = DispatchGroup()
                            
                            for characterUrl in film.characters! {
                                group.enter()
                                API.getCharacterInfo(
                                    url: characterUrl,
                                    success: { (character) in
                                        self.characters.append(character)
                                        group.leave()
                                },
                                    failure: { (error) in print(error)})
                            }
                            
                            group.notify(queue: .main) {
                                var charactersString: [String] = []
                                cell.activityIndicator.isHidden = true
                                
                                for character in self.characters {
                                    if let name = character.name {
                                        if (!charactersString.contains(name)) {
                                            charactersString.append(name)
                                        }
                                    }
                                }
                                
                                print(charactersString)
                                
                                cell.stringArray = charactersString
                                cell.bgColorForCollectionViewCell = UIColor.orange
                                cell.bgColorForCollectionViewCellLabel = UIColor.black
                                cell.isBackgroundClear = true
                                
                                cell.lblType.isHidden = false
                                cell.collectionView.isHidden = false
                                
                                cell.collectionView.reloadData()
                                tableView.reloadData()
                            }
                        }
                    } else {
                        cell.lblValue.text = "N/A"
                    }
                case 6:
                    cell = tableView.dequeueReusableCell(withIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_COLLECTION-PLANETS") as! DetailTableViewCell
                    cell.lblType.text = "Planets"
                
                    if (film.planets!.count > 0) {
                        cell.lblValue.isHidden = true
                        
                        if (self.planets.count == 0) {
                            cell.activityIndicator.isHidden = false
                            let group = DispatchGroup()
                            
                            for planetUrl in film.planets! {
                                group.enter()
                                API.getHomeworldInfo(
                                    url: planetUrl,
                                    success: { (planet) in
                                        self.planets.append(planet)
                                        group.leave()
                                },
                                    failure: { (error) in print(error)})
                            }
                            
                            group.notify(queue: .main) {
                                var planetsString: [String] = []
                                cell.activityIndicator.isHidden = true
                                
                                for planet in self.planets {
                                    if let name = planet.name {
                                        if (!planetsString.contains(name.capitalized)) {
                                            planetsString.append(name.capitalized)
                                        }
                                    }
                                }
                                
                                print(planetsString)
                                
                                cell.stringArray = planetsString
                                cell.bgColorForCollectionViewCell = UIColor(red: 0, green: 140/255, blue: 25/255, alpha: 1)
                                cell.bgColorForCollectionViewCellLabel = UIColor.black
                                cell.isBackgroundClear = true
                                
                                cell.lblType.isHidden = false
                                cell.collectionView.isHidden = false
                                
                                cell.collectionView.reloadData()
                                tableView.reloadData()
                            }
                        }
                    } else {
                        cell.lblValue.text = "N/A"
                    }
                case 7:
                    cell = tableView.dequeueReusableCell(withIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_COLLECTION-STARSHIPS") as! DetailTableViewCell
                    cell.lblType.text = "Starships"
                
                    if (film.starships!.count > 0) {
                        cell.lblValue.isHidden = true
                        
                        if (self.starships.count == 0) {
                            cell.activityIndicator.isHidden = false
                            let group = DispatchGroup()
                            
                            for starshipUrl in film.starships! {
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
                                cell.bgColorForCollectionViewCellLabel = UIColor.black
                                cell.isBackgroundClear = true
                                
                                cell.lblType.isHidden = false
                                cell.collectionView.isHidden = false
                                
                                cell.collectionView.reloadData()
                                tableView.reloadData()
                            }
                        }
                    } else {
                        cell.lblValue.text = "N/A"
                    }
                case 8:
                    cell = tableView.dequeueReusableCell(withIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_COLLECTION-VEHICLES") as! DetailTableViewCell
                    cell.lblType.text = "Vehicles"
                
                    if (film.vehicles!.count > 0) {
                        cell.lblValue.isHidden = true
                        
                        if (self.vehicles.count == 0) {
                            cell.activityIndicator.isHidden = false
                            let group = DispatchGroup()
                            
                            for vehicleUrl in film.vehicles! {
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
                                cell.bgColorForCollectionViewCellLabel = UIColor.black
                                cell.isBackgroundClear = true
                                
                                cell.lblType.isHidden = false
                                cell.collectionView.isHidden = false
                                
                                cell.collectionView.reloadData()
                                tableView.reloadData()
                            }
                        }
                    } else {
                        cell.lblValue.text = "N/A"
                    }
                case 9:
                    cell = tableView.dequeueReusableCell(withIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_COLLECTION-SPECIES") as! DetailTableViewCell
                    cell.lblType.text = "Species"
                
                    if (film.species!.count > 0) {
                        cell.lblValue.isHidden = true
                        
                        if (self.species.count == 0) {
                            cell.activityIndicator.isHidden = false
                            let group = DispatchGroup()
                            
                            for speciesUrl in film.species! {
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
                                cell.bgColorForCollectionViewCellLabel = UIColor.black
                                cell.isBackgroundClear = true
                                
                                cell.lblType.isHidden = false
                                cell.collectionView.isHidden = false
                                
                                cell.collectionView.reloadData()
                                tableView.reloadData()
                            }
                        }
                    } else {
                        cell.lblValue.text = "N/A"
                    }
                default:
                    cell.lblType.text = ""
                    cell.lblValue.text = ""
            }
        } else if let species = object as? Species {
            switch indexPath.row {
                case 0:
                    cell.lblType.text = "Classification"
                    cell.lblValue.text = species.classification?.capitalized
                case 1:
                    cell.lblType.text = "Designation"
                    cell.lblValue.text = species.designation?.capitalized
                case 2:
                    cell.lblType.text = "Average Height"
                    if (Double(species.average_height!) != nil)  {
                        cell.lblValue.text = "\(Measurement(value: Double(species.average_height!) as! Double, unit: UnitLength.centimeters).converted(to: UnitLength.meters))"
                    } else {
                        cell.lblValue.text = species.average_height!.capitalized
                    }
                case 3:
                    cell.lblType.text = "Skin Colors"
                    cell.lblValue.text = species.skin_colors?.capitalized
                case 4:
                    cell.lblType.text = "Hair Colors"
                    cell.lblValue.text = species.hair_colors!.capitalized
                case 5:
                    cell.lblType.text = "Eye Colors"
                    cell.lblValue.text = species.eye_colors!.capitalized
                case 6:
                    cell.lblType.text = "Average Lifespan"
                    if (Int(species.average_lifespan!) != nil) {
                        cell.lblValue.text = formatInt(inputNumber: species.average_lifespan!) + " years"
                    } else {
                        cell.lblValue.text = species.average_lifespan!.capitalized
                    }
                case 7:
                    cell = tableView.dequeueReusableCell(withIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_COLLECTION-PLANETS") as! DetailTableViewCell
                    cell.lblType.text = "Homeworld"
                    
                    if (species.homeworld != nil) {
                        if (species.homeworld!.contains("https://")) {
                            cell.lblValue.isHidden = true
                            
                            if (self.planets.count == 0) {
                                cell.activityIndicator.isHidden = false
                                
                                API.getHomeworldInfo(
                                    url: species.homeworld!,
                                    success: { (planet) in
                                        self.planets.append(planet)
                                        var planetsString: [String] = []
                                        cell.activityIndicator.isHidden = true
                                        
                                        for planet in self.planets {
                                            if let name = planet.name {
                                                if (!planetsString.contains(name)) {
                                                    planetsString.append(name.capitalized)
                                                }
                                            }
                                        }
                                        
                                        print(planetsString)
                                        
                                        cell.stringArray = planetsString
                                        cell.bgColorForCollectionViewCell = UIColor(red: 0, green: 140/255, blue: 25/255, alpha: 1)
                                        cell.bgColorForCollectionViewCellLabel = UIColor.black
                                        cell.isBackgroundClear = true
                                        
                                        cell.lblType.isHidden = false
                                        cell.collectionView.isHidden = false
                                        
                                        cell.collectionView.reloadData()
                                        tableView.reloadData()
                                },
                                    failure: { (error) in print(error)})
                            }
                        } else {
                            cell.lblValue.text = species.homeworld!.capitalized
                        }
                    } else {
                        cell.lblValue.text = "N/A"
                    }
                case 8:
                    cell.lblType.text = "Language"
                    cell.lblValue.text = species.language!.capitalized
                case 9:
                    cell = tableView.dequeueReusableCell(withIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_COLLECTION-CHARACTERS") as! DetailTableViewCell
                    cell.lblType.text = "People"
                
                    if (species.people!.count > 0) {
                        cell.lblValue.isHidden = true
                        
                        if (self.characters.count == 0) {
                            cell.activityIndicator.isHidden = false
                            let group = DispatchGroup()
                            
                            for characterUrl in species.people! {
                                group.enter()
                                API.getCharacterInfo(
                                    url: characterUrl,
                                    success: { (character) in
                                        self.characters.append(character)
                                        group.leave()
                                },
                                    failure: { (error) in print(error)})
                            }
                            
                            group.notify(queue: .main) {
                                var charactersString: [String] = []
                                cell.activityIndicator.isHidden = true
                                
                                for character in self.characters {
                                    if let name = character.name {
                                        if (!charactersString.contains(name)) {
                                            charactersString.append(name)
                                        }
                                    }
                                }
                                
                                print(charactersString)
                                
                                cell.stringArray = charactersString
                                cell.bgColorForCollectionViewCell = UIColor.orange
                                cell.bgColorForCollectionViewCellLabel = UIColor.black
                                cell.isBackgroundClear = true
                                
                                cell.lblType.isHidden = false
                                cell.collectionView.isHidden = false
                                
                                cell.collectionView.reloadData()
                                tableView.reloadData()
                            }
                        }
                    } else {
                        cell.lblValue.text = "N/A"
                    }
                case 10:
                    cell = tableView.dequeueReusableCell(withIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_COLLECTION-FILMS") as! DetailTableViewCell
                    cell.lblType.text = "Films"
                
                    if (species.films!.count > 0) {
                        cell.lblType.text = "Films"
                        cell.lblValue.isHidden = true
                        
                        if (self.films.count == 0) {
                            cell.activityIndicator.isHidden = false
                            let group = DispatchGroup()
                            
                            for filmUrl in species.films! {
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
                                            filmsString.append(title.capitalized)
                                        }
                                    }
                                }
                                
                                print(filmsString)
                                
                                cell.stringArray = filmsString
                                cell.bgColorForCollectionViewCell = UIColor.brown
                                cell.bgColorForCollectionViewCellLabel = UIColor.black
                                cell.isBackgroundClear = true
                                
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
                default:
                    cell.lblType.text = ""
                    cell.lblValue.text = ""
            }
        } else if let vehicle = object as? Vehicle {
            switch indexPath.row {
                case 0:
                    cell.lblType.text = "Model"
                    cell.lblValue.text = vehicle.model?.capitalized
                case 1:
                    cell.lblType.text = "Manufacturer"
                    cell.lblValue.text = vehicle.manufacturer?.capitalized
                case 2:
                    cell.lblType.text = "Cost (In Credits)"
                    if (Double(vehicle.cost_in_credits!) != nil)  {
                        cell.lblValue.text = formatInt(inputNumber: vehicle.cost_in_credits!)
                    } else {
                        cell.lblValue.text = vehicle.cost_in_credits!.capitalized
                    }
                case 3:
                    cell.lblType.text = "Length"
                    if (Double(vehicle.length!) != nil)  {
                        cell.lblValue.text = "\(Measurement(value: Double(vehicle.length!) as! Double, unit: UnitLength.meters))"
                    } else {
                        cell.lblValue.text = vehicle.length!.capitalized
                    }
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
                    if (Double(vehicle.cargo_capacity!) != nil)  {
                        cell.lblValue.text = "\(Measurement(value: Double(vehicle.cargo_capacity!) as! Double, unit: UnitMass.kilograms))"
                    } else {
                        cell.lblValue.text = vehicle.cargo_capacity!.capitalized
                    }
                case 8:
                    cell.lblType.text = "Consumables"
                    cell.lblValue.text = vehicle.consumables?.capitalized
                case 9:
                    cell.lblType.text = "Vehicle Class"
                    cell.lblValue.text = vehicle.vehicle_class?.capitalized
                case 10:
                    cell = tableView.dequeueReusableCell(withIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_COLLECTION-CHARACTERS") as! DetailTableViewCell
                    cell.lblType.text = "Pilots"
                    
                    if (vehicle.pilots!.count > 0) {
                        cell.lblValue.isHidden = true
                        
                        if (self.characters.count == 0) {
                            cell.activityIndicator.isHidden = false
                            let group = DispatchGroup()
                            
                            for characterUrl in vehicle.pilots! {
                                group.enter()
                                API.getCharacterInfo(
                                    url: characterUrl,
                                    success: { (character) in
                                        self.characters.append(character)
                                        group.leave()
                                },
                                    failure: { (error) in print(error)})
                            }
                            
                            group.notify(queue: .main) {
                                var charactersString: [String] = []
                                cell.activityIndicator.isHidden = true
                                
                                for character in self.characters {
                                    if let name = character.name {
                                        if (!charactersString.contains(name)) {
                                            charactersString.append(name)
                                        }
                                    }
                                }
                                
                                print(charactersString)
                                
                                cell.stringArray = charactersString
                                cell.bgColorForCollectionViewCell = UIColor.orange
                                cell.bgColorForCollectionViewCellLabel = UIColor.black
                                cell.isBackgroundClear = true
                                
                                cell.lblType.isHidden = false
                                cell.collectionView.isHidden = false
                                
                                cell.collectionView.reloadData()
                                tableView.reloadData()
                            }
                        }
                    } else {
                        cell.lblValue.text = "N/A"
                    }
                case 11:
                    cell = tableView.dequeueReusableCell(withIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_COLLECTION-FILMS") as! DetailTableViewCell
                    cell.lblType.text = "Films"
                    
                    if (vehicle.films!.count > 0) {
                        cell.lblValue.isHidden = true
                        
                        if (self.films.count == 0) {
                            cell.activityIndicator.isHidden = false
                            let group = DispatchGroup()
                            
                            for filmUrl in vehicle.films! {
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
                                cell.bgColorForCollectionViewCellLabel = UIColor.black
                                cell.isBackgroundClear = true
                                
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
                default:
                    cell.lblType.text = ""
                    cell.lblValue.text = ""
            }
        } else if let starship = object as? Starship {
            switch indexPath.row {
                case 0:
                    cell.lblType.text = "Model"
                    cell.lblValue.text = starship.model?.capitalized
                case 1:
                    cell.lblType.text = "Manufacturer"
                    cell.lblValue.text = starship.manufacturer?.capitalized
                case 2:
                    cell.lblType.text = "Cost (In Credits)"
                    if (Double(starship.cost_in_credits!) != nil)  {
                        cell.lblValue.text = formatInt(inputNumber: starship.cost_in_credits!)
                    } else {
                        cell.lblValue.text = starship.cost_in_credits!.capitalized
                    }
                case 3:
                    cell.lblType.text = "Length"
                    if (Double(starship.length!) != nil)  {
                        cell.lblValue.text = "\(Measurement(value: Double(starship.length!) as! Double, unit: UnitLength.meters))"
                    } else {
                        cell.lblValue.text = starship.length!.capitalized
                    }
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
                    if (Double(starship.cargo_capacity!) != nil)  {
                        cell.lblValue.text = "\(Measurement(value: Double(starship.cargo_capacity!) as! Double, unit: UnitMass.kilograms))"
                    } else {
                        cell.lblValue.text = starship.cargo_capacity!.capitalized
                    }
                case 8:
                    cell.lblType.text = "Consumables"
                    cell.lblValue.text = starship.consumables?.capitalized
                case 9:
                    cell.lblType.text = "Hyperdrive Rating"
                    cell.lblValue.text = starship.hyperdrive_rating
                case 10:
                    cell.lblType.text = "Megalight Per Hour"
                    cell.lblValue.text = starship.MGLT
                case 11:
                    cell.lblType.text = "Starship Class"
                    cell.lblValue.text = starship.starship_class?.capitalized
                case 12:
                    cell = tableView.dequeueReusableCell(withIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_COLLECTION-CHARACTERS") as! DetailTableViewCell
                    cell.lblType.text = "Pilots"
                
                    if (starship.pilots!.count > 0) {
                        cell.lblValue.isHidden = true
                        
                        if (self.characters.count == 0) {
                            cell.activityIndicator.isHidden = false
                            let group = DispatchGroup()
                            
                            for characterUrl in starship.pilots! {
                                group.enter()
                                API.getCharacterInfo(
                                    url: characterUrl,
                                    success: { (character) in
                                        self.characters.append(character)
                                        group.leave()
                                },
                                    failure: { (error) in print(error)})
                            }
                            
                            group.notify(queue: .main) {
                                var charactersString: [String] = []
                                cell.activityIndicator.isHidden = true
                                
                                for character in self.characters {
                                    if let name = character.name {
                                        if (!charactersString.contains(name)) {
                                            charactersString.append(name)
                                        }
                                    }
                                }
                                
                                print(charactersString)
                                
                                cell.stringArray = charactersString
                                cell.bgColorForCollectionViewCell = UIColor.orange
                                cell.bgColorForCollectionViewCellLabel = UIColor.black
                                cell.isBackgroundClear = true
                                
                                cell.lblType.isHidden = false
                                cell.collectionView.isHidden = false
                                
                                cell.collectionView.reloadData()
                                tableView.reloadData()
                            }
                        }
                    } else {
                        cell.lblValue.text = "N/A"
                    }
                case 13:
                    cell = tableView.dequeueReusableCell(withIdentifier: "DEFAULT_TABLEVIEWGENDETAILS_CELL_ID_COLLECTION-FILMS") as! DetailTableViewCell
                    cell.lblType.text = "Films"
                
                    if (starship.films!.count > 0) {
                        cell.lblValue.isHidden = true
                        
                        if (self.films.count == 0) {
                            cell.activityIndicator.isHidden = false
                            let group = DispatchGroup()
                            
                            for filmUrl in starship.films! {
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
                                cell.bgColorForCollectionViewCellLabel = UIColor.black
                                cell.isBackgroundClear = true
                                
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
