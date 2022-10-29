//
//  Extension+Int.swift
//  SeSAC MVVM Project
//
//  Created by 이명진 on 2022/10/28.
//

import UIKit


extension Int {
    func numberFormatter() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return self.formatted()
    }
}
