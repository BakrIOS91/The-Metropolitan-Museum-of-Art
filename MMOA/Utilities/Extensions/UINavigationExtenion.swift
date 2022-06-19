//
//  UINavigationExtenion.swift
//  MMOA
//
//  Created by Bakr mohamed on 19/06/2022.
//

import SwiftUI

extension UINavigationController {
    
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
    
}
