//
//  ViewController.swift
//  Star Wars
//
//  Created by Victor Hugo Telles on 29/05/19.
//  Copyright © 2019 Victor Hugo Telles. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBarMain: UISearchBar!
    @IBOutlet weak var viewLogoSearchBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBarColors()
        setupHideKeyboardOnTap()
        viewLogoSearchBar.bindToKeyboard()
        self.searchBarMain.delegate = self
    }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar) {
        if (!searchBar.text!.isEmpty) {
//            print(searchBar.text!)
            // Enviar texto da busca para próxima página e listar requests
        } else {
            showToast(message: "A busca não pode estar vazia.")
        }
    }
    
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
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
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }

}

