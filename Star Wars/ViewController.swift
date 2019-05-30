//
//  ViewController.swift
//  Star Wars
//
//  Created by Victor Hugo Telles on 29/05/19.
//  Copyright © 2019 Victor Hugo Telles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBarMain: UISearchBar!
    @IBOutlet weak var viewLogoSearchBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearSearchBarBackgroundColor()
        viewLogoSearchBar.bindToKeyboard()
        
        setupHideKeyboardOnTap()
    }
    
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    /// Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
    
    deinit {
        viewLogoSearchBar.unbindFromKeyboard()
    }
    
    private func clearSearchBarBackgroundColor() {
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

