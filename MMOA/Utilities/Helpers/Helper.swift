//
//  Helper.swift
//  MMOA
//
//  Created by Bakr mohamed on 16/06/2022.
//

import Foundation

func wait(_ duration: Double, _ action: @escaping(() -> Void)) {
    DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: action)
}
