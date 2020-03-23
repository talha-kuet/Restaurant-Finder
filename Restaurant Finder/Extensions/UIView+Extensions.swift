//
//  UIView+Extensions.swift
//  Restaurant Finder
//
//  Created by Musaddique Billah Talha on 3/20/20.
//

import UIKit

extension UIView {
    
    class func viewFromNibName(_ name: String) -> UIView? {
      let views = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
      return views?.first as? UIView
    }
}
