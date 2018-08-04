//
//  PasswordTextField.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 15/04/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import UIKit

@IBDesignable
class PasswordTextField: UITextField {

    @IBInspectable var showPasswordIcon : UIImage = UIImage(named: "show", in: Bundle(for: PasswordTextField.self), compatibleWith: nil)!
    @IBInspectable var hidePasswordIcon : UIImage = UIImage(named: "hide", in: Bundle(for: PasswordTextField.self), compatibleWith: nil)!
    
     let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 30)
     var toggleButton : UIButton = UIButton()
     var safetyCheck: Bool = true

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        awakeFromNib2()
    }
 
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        awakeFromNib2()
    }
    
    func awakeFromNib2() {
        
        toggleButton = UIButton(frame: CGRect(x: self.frame.width - self.frame.height, y: 0, width: self.frame.height, height: self.frame.height))
        toggleButton.setImage(showPasswordIcon, for: UIControlState.normal)
        toggleButton.setImage(hidePasswordIcon, for: UIControlState.selected)
        toggleButton.isSelected = self.isSecureTextEntry
        toggleButton.isHidden = true;
        toggleButton.addTarget(self, action: #selector(onShowClick(sender:)), for: .touchUpInside)
        self.addSubview(toggleButton)
        
        
        if(safetyCheck) {
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.borderWidth = 1
            self.layer.cornerRadius = 4
        }
        
        self.addTarget(self, action: #selector(onEditingBegin(sender:)), for: .editingDidBegin)
        self.addTarget(self, action: #selector(onEditingChanged(sender:)), for: .editingChanged)
        self.addTarget(self, action: #selector(onEditingEnd(sender:)), for: .editingDidEnd)
    }
 
    public func registerIcons(showIcon:UIImage, hideIcon:UIImage) {
        self.toggleButton.setImage(showIcon, for: .normal);
        self.toggleButton.setImage(hideIcon, for: .selected);
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews();
        self.toggleButton.frame = CGRect(x: self.frame.width - self.frame.height, y: 0, width: self.frame.height, height: self.frame.height);
        
        self.layer.borderColor = UIColor(white: 231/255, alpha: 1).cgColor
        self.layer.borderWidth = 1
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding);
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding);
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding);
    }
    
    
    @objc func onShowClick(sender:UIButton) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        self.toggleButton.isSelected = self.isSecureTextEntry
    }
  
    @objc func onEditingBegin(sender:UITextField) {
        self.toggleButton.isHidden = false
        if(safetyCheck) {
            self.layer.borderColor = UIColor.blue.cgColor
        }
    }
    
    @objc func onEditingChanged(sender:UITextField) {
        if(safetyCheck) {
            UIView.animate(withDuration: 0.2) {
                self.layer.borderColor = UIColor.blue.cgColor
            }
        }
    }
    
    @objc func onEditingEnd(sender:UITextField) {

        self.toggleButton.isHidden = true
        if(safetyCheck) {
            self.layer.borderColor = UIColor.clear.cgColor
        }
    }
}
