//
//  ViewController.swift
//  Star Wars
//
//  Created by Victor Hugo Telles on 29/05/19.
//  Copyright © 2019 Victor Hugo Telles. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBarMain: UISearchBar!
    @IBOutlet weak var viewLogoSearchBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBarColors()
        self.setupHideKeyboardOnTap()
        viewLogoSearchBar.bindToKeyboard()
        self.searchBarMain.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.viewLogoSearchBar.center = self.view.center
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
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
            showToast(message: "A busca não pode estar vazia.")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MainToResults") {
            let vc = segue.destination as! SearchListViewController
            vc.query = searchBarMain.text!
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
