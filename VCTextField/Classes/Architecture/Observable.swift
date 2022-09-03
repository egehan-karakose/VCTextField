//
//  Observable.swift
//  VTextField
//
//  Created by Egehan KARAKÖSE (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 2.09.2022.
//

import Foundation

public protocol BaseObservableProtocol {
    
    func removeObservers()
}

public typealias Observer<T> = (T) -> Void

public class Observable<T>: BaseObservableProtocol {
    
    private let thread: DispatchQueue
    
    private var observer: Observer<T>?
    
    public var data: T? {
        didSet {
            if let data = self.data {
                thread.async { [weak self] in
                    self?.observer?(data)
                }
            }
        }
    }
    
    private var reservedData: T?
    
    public init(_ data: T? = nil, thread: DispatchQueue = DispatchQueue.main) {
        self.thread = thread
        self.data = data
    }
    
    public func setWithoutNotify(_ data: T?) {
        self.reservedData = data
    }
    
    public func send(_ data: T?) {
        self.data = data
    }
    
    public func sendSignal(useReserved: Bool = false) {
        if useReserved, let data = self.reservedData {
            self.data = data
        } else if let data = self.data {
            thread.async { [weak self] in
                self?.observer?(data)
            }
        }
    }
    
    public func addObserver(observer: @escaping ((T) -> Void)) {
        self.observer = observer
    }
    
    public func removeObservers() {
        observer = nil
    }
}


