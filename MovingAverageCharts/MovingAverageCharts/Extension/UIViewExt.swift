//
//  UIViewExt.swift
//  MovingAverageCharts
//
//  Created by woanjwu liauh on 2022/5/20.
//

import Foundation
import UIKit

extension UIView {
    
    func loadViewFromXib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

