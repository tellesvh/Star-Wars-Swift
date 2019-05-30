//
//  Toast.swift
//  Star Wars
//
//  Created by Victor Hugo Telles on 30/05/19.
//  Copyright © 2019 Victor Hugo Telles. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showToast(message : String) {
        
        let topPadding = view.safeAreaInsets.top
        
//        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 110, y: 10 + topPadding, width: 220, height: 35))
        toastLabel.backgroundColor = UIColor.white.withAlphaComponent(0.45)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
//        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.font = toastLabel.font.withSize(12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 0.5, delay: 3.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
