//
//  RZLabelSizeController.swift
//  RelizKit
//
//  Created by Александр Сенин on 26.10.2020.
//

import UIKit

class RZLabelSizeController{
    enum LabelSizeMod {
        case sizes
        case font(UIFont)
        case sizeToFit
    }
    
    static func setMod(_ view: UIView, _ mod: LabelSizeMod){
        guard let key = UnsafeRawPointer(bitPattern: 2) else {return}
        var labelSize = objc_getAssociatedObject(view, key) as? RZLabelSize
        if labelSize == nil{
            labelSize = RZLabelSize()
            objc_setAssociatedObject(view, key, labelSize, .OBJC_ASSOCIATION_RETAIN)
        }
        switch mod{
        case .sizeToFit:
            labelSize?.view = view
            labelSize?.sizeToFit = true
        case .sizes:
            labelSize?.view = view
            labelSize?.sizes = true
        case .font(let font):
            labelSize?.difoulFont = font
        }
    }
    
    static func modUpdate(_ view: UIView){
        guard let key = UnsafeRawPointer(bitPattern: 2) else {return}
        guard let labelSize = objc_getAssociatedObject(view, key) as? RZLabelSize else {return}
        labelSize.update()
    }
}

class RZLabelSize{
    var difoulFont: UIFont?
    var sizes: Bool = false
    var sizeToFit: Bool = false
    weak var view: UIView?
    
    func update(){
        if sizeToFit { view?.sizeToFit() }
        if sizes { sizesView() }
    }
    
    func sizesView(){
        guard let view = view as? UILabel else { return }
        let difoulFont = self.difoulFont ?? view.font
        
        view.font = difoulFont
        let widthL = view.frame.width
        view.sizeToFit()
        
        if view.frame.width > widthL{
            let coof = widthL / view.frame.width
            view.font = view.font.withSize(view.font.pointSize * coof)
            view.frame.size.width = widthL
        }
    }
}
