//
//  PublisherExtension.swift
//  MMOA
//
//  Created by Bakr mohamed on 16/06/2022.
//

import Combine

extension Publisher {
    public func mapToVoid() -> Publishers.Map<Self, Void> {
        map { _ in }
    }
}
