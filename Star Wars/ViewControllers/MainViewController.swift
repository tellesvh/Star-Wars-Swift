//
//  ViewController.swift
//  Star Wars
//
//  Created by Victor Hugo Telles on 29/05/19.
//  Copyright © 2019 Victor Hugo Telles. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var searchBarMain: UISearchBar!
    @IBOutlet weak var viewLogoSearchBar: UIView!
    @IBOutlet weak var collectionViewFavorites: UICollectionView!
    var itemClicked: Character?
    var favorites: [Character] = []
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBarColors()
        self.setupHideKeyboardOnTap()
        viewLogoSearchBar.bindToKeyboard()
        self.searchBarMain.delegate = self
        
        self.collectionViewFavorites.register(UINib.init(nibName: "DetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionViewID")
        self.collectionViewFavorites.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        if let flowLayout = self.collectionViewFavorites?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.itemClicked = favorites[indexPath.row]
        performSegue(withIdentifier: "MainToDetail", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewID", for: indexPath as IndexPath) as! DetailCollectionViewCell
        
        cell.lblCollectionViewCell.text = favorites[indexPath.row].name
        cell.lblCollectionViewCell.textColor = UIColor.white
        cell.collectionViewCellView.backgroundColor = UIColor.orange
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGSize = favorites[indexPath.row].name!.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24.0)])
        print(size)
        return CGSize(width: size.width + 44, height: 30)
    }
    
    func convertResultsFromRealm() {
        let favorites: Results<CharacterRealm> = realm.objects(CharacterRealm.self)
        
        for characterRealm in favorites {
            var films: [String] = []
            for film in characterRealm.films {
                films.append(film)
            }
            var speciesArray: [String] = []
            for species in characterRealm.species {
                speciesArray.append(species)
            }
            var vehicles: [String] = []
            for vehicle in characterRealm.vehicles {
                vehicles.append(vehicle)
            }
            var starships: [String] = []
            for starship in characterRealm.starships {
                starships.append(starship)
            }
            
            let character = Character(name: characterRealm.name, height: characterRealm.height, mass: characterRealm.mass, hair_color: characterRealm.hair_color, skin_color: characterRealm.skin_color, eye_color: characterRealm.eye_color, birth_year: characterRealm.birth_year, gender: characterRealm.gender, homeworld: characterRealm.homeworld, films: films, species: speciesArray, vehicles: vehicles, starships: starships, created: nil, edited: nil, url: nil)
            
            self.favorites.append(character)
        }
        
        collectionViewFavorites.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.favorites.removeAll()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.viewLogoSearchBar.center = self.view.center
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
        
        convertResultsFromRealm()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        searchBarMain.text = ""
    }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar) {
        if (!searchBar.text!.isEmpty) {
            self.view.endEditing(true)
            performSegue(withIdentifier: "MainToResults", sender: self)
        } else {
            showToast(message: "The search can not be empty.")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MainToResults") {
            let vc = segue.destination as! SearchListViewController
            vc.query = searchBarMain.text!
        } else if (segue.identifier == "MainToDetail") {
            let vc = segue.destination as! DetailsViewController
            vc.character = self.itemClicked
        }
    }
    
    deinit {
        viewLogoSearchBar.unbindFromKeyboard()
    }
    
    private func setupSearchBarColors() {
        searchBarMain.barTintColor = UIColor.clear
        searchBarMain.backgroundColor = UIColor.clear
        searchBarMain.isTranslucent = true
        searchBarMain.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
