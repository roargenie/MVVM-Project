//
//  Extension+UIImageView.swift
//  SeSAC MVVM Project
//
//  Created by 이명진 on 2022/10/28.
//

import UIKit


extension UIImageView {
    
    func makeRoundedCorners(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        //self.layer.masksToBounds = true
    }

    func makeToCircle() {
        self.makeRoundedCorners(self.frame.width / 2)
    }
    
}
