//
//  Helper.swift
// 

import Foundation

func wait(_ duration: Double = 2, _ action: @escaping(() -> Void)) {
    DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: action)
}
