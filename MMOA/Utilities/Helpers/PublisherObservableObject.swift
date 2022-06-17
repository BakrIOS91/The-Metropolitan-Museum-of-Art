//
//  PublisherObservableObject.swift
//  MMOA
//
//  Created by Bakr mohamed on 17/06/2022.
//

import SwiftUI
import Combine

final class PublisherObservableObject: ObservableObject {
    
    var subscriber: AnyCancellable?
    
    init(publisher: AnyPublisher<Void, Never>) {
        subscriber = publisher.sink(receiveValue: { [weak self] _ in
            self?.objectWillChange.send()
        })
    }
}
