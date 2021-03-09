//
//  RZProtoValueGoup.swift
//  RelizKit
//
//  Created by Александр Сенин on 21.10.2020.
//

import UIKit

protocol RZProtoOperationProtocol {
    func checkObserv(
        _ tag: RZObserveController.Tag,
        _ observeController: RZObserveController?,
        _ closure: @escaping ((UIView) -> ())
    )
    func getValue(_ frame: CGRect) -> CGFloat
}
extension RZProtoOperationProtocol{
    func checkObservAt(
        _ value: RZProtoValueProtocol,
        _ tag: RZObserveController.Tag,
        _ observeController: RZObserveController?,
        _ closure: @escaping ((UIView) -> ())
    ){
        if let value = value as? RZProtoValue{
            value.checkObserv(tag, observeController, closure)
        }
        if let value = value as? RZObservable<RZProtoValue>{
            value.add {[weak observeController] proto in
                guard let observeController = observeController else {return}
                guard let view = observeController.view else {return}
                proto.checkObserv(tag, observeController, closure)
                closure(view)
            }
        }
    }
}

class RZProtoOperation: RZProtoOperationProtocol{
    var value: RZProtoValueProtocol
    var type: RZProtoOperationType
    
    enum RZProtoOperationType {
        case reverst
        case wrap
    }
    
    init(_ value: RZProtoValueProtocol, _ type: RZProtoOperationType){
        self.value = value
        self.type = type
    }
    
    func checkObserv(
        _ tag: RZObserveController.Tag,
        _ observeController: RZObserveController?,
        _ closure: @escaping ((UIView) -> ())
    ){
        checkObservAt(value, tag, observeController, closure)
    }
    
    func getValue(_ frame: CGRect) -> CGFloat {
        switch type {
            case .reverst: return -value.getValue(frame)
            case .wrap:    return value.getValue(frame)
        }
    }
}

class RZProtoOperationGoup: RZProtoOperationProtocol {
    var spaceFirst: RZProtoValueProtocol
    var spaceSecond: RZProtoValueProtocol
    var type: RZProtoValueRangtType
    
    enum RZProtoValueRangtType {
        case rang
        case center
        case procent
        
        case p
        case m
        case u
        case d
    }
    
    init(_ spaceFirst: RZProtoValueProtocol, _ spaceSecond: RZProtoValueProtocol, _ type: RZProtoValueRangtType){
        self.spaceFirst = spaceFirst
        self.spaceSecond = spaceSecond
        self.type = type
    }
    
    func checkObserv(
        _ tag: RZObserveController.Tag,
        _ observeController: RZObserveController?,
        _ closure: @escaping ((UIView) -> ())
    ){
        checkObservAt(spaceFirst, tag, observeController, closure)
        checkObservAt(spaceSecond, tag, observeController, closure)
    }
    
    func getValue(_ frame: CGRect) -> CGFloat{
        let first = spaceFirst.getValue(frame)
        let second = spaceSecond.getValue(frame)
        
        switch type {
        case .rang:
            return first > second ? first - second : second - first
        case .center:
            var rang = first > second ? first - second : second - first
            rang /= 2
            rang += first < second ? first : second
            return rang
        case .procent:
            let procent = second / 100 * first
            if
                let spaceSecond = spaceSecond as? RZProtoValue,
                let opiration = spaceSecond.operation as? RZProtoOperation,
                opiration.type == .reverst
            {
                return -(second - procent)
            }
            return procent
        case .p:
            return first + second
        case .m:
            return first - second
        case .u:
            return first * second
        case .d:
            return first / second
        }
    }
}
