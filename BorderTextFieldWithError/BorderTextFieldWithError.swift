//
//  BorderTextFieldWithError.swift
//  BorderTextFieldWithError
//
//  Created by JRU on 2025/4/10.
//

import UIKit

class BorderTextFieldWithErrorMsg: UITextField {
    
    private var titleLabel: UILabel!
    private var errorLabel: UILabel!
    private var borderView: UIView!
    private var heightConstraint: NSLayoutConstraint!
    
    private var _titleText: String? {
        didSet {
            titleLabel.text = _titleText
            titleLabel.isHidden = _titleText?.isEmpty == true || _titleText == nil
            if titleLabel.isHidden {
                borderView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
            }
            updateHeight()
        }
    }
    
    private var _errorMsg: String? {
        didSet {
            errorLabel.text = _errorMsg
            errorLabel.isHidden = _errorMsg?.isEmpty == true || _errorMsg == nil
            updateHeight()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setTitleLabel()
        setErrorLabel()
        setBorderView()
        setUpConstraints()
        
        autocorrectionType = .no
        spellCheckingType = .no
    }
    
    override var placeholder: String? {
        didSet {
            guard let placeholder = self.placeholder else { return }
            self.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [
                    .foregroundColor: UIColor.systemGray4,
                    .font: UIFont.systemFont(ofSize: 12)
                ]
            )
        }
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return setTextRect(forBounds: bounds)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return setTextRect(forBounds: bounds)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let textHeight = font?.lineHeight ?? 20
        let borderMidY = borderView.frame.midY
        let yPosition = borderMidY - (textHeight / 2)
        return CGRect(x: 12, y: yPosition, width: bounds.width - 24, height: textHeight)
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let buttonWidth: CGFloat = 30
        let buttonHeight: CGFloat = 30
        let xPosition = bounds.maxX - buttonWidth
        let yPosition = self.borderView.frame.minY + ((self.borderView.frame.size.height / 2) - (buttonHeight / 2))
        return CGRect(x: xPosition - 12, y: yPosition, width: buttonWidth, height: buttonHeight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let rightView = rightView else { return }
        let rightViewSize = rightView.frame.size
        let yPosition = self.borderView.frame.minY + ((self.borderView.frame.size.height / 2) - (rightViewSize.height / 2))
        rightView.frame = CGRect(x: bounds.width - rightViewSize.width - 12, y: yPosition, width: rightViewSize.width, height: rightViewSize.height)
        self.rightViewMode = .always
    }
    
    override func becomeFirstResponder() -> Bool {
        _errorMsg = nil
        borderView.layer.borderColor = UIColor.purple.cgColor
        updateHeight()
        self.tintColor = UIColor.purple
        super.becomeFirstResponder()
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        borderView.layer.borderColor = UIColor.systemGray6.cgColor
        super.resignFirstResponder()
        return true
    }
    
    func setTitleInfo(titleText: String?) {
        self._titleText = titleText
    }
    
    func setErrorInfo(errorText: String?) {
        _errorMsg = errorText
    }
}
extension BorderTextFieldWithErrorMsg {
    
    private func setBorderView() {
        borderStyle = .none
        
        borderView = UIView()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        
        borderView.layer.cornerRadius = 4
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor.systemGray6.cgColor
        borderView.isUserInteractionEnabled = false
        
        addSubview(borderView)
        sendSubviewToBack(borderView)
    }
    
    private func setTitleLabel() {
        titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.clipsToBounds = true
        titleLabel.textColor = UIColor.gray
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.layer.backgroundColor = UIColor.clear.cgColor
        self.addSubview(titleLabel)
    }
    
    private func setErrorLabel() {
        errorLabel = UILabel(frame: CGRect.zero)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.clipsToBounds = true
        errorLabel.textColor = UIColor.red
        errorLabel.font = UIFont.systemFont(ofSize: 12)
        errorLabel.layer.backgroundColor = UIColor.clear.cgColor
        errorLabel.numberOfLines = 0
        self.addSubview(errorLabel)
    }
    
    private func setUpConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        heightConstraint = heightAnchor.constraint(equalToConstant: 63)
        heightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            
            borderView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 40),
            
            errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            errorLabel.topAnchor.constraint(equalTo: borderView.bottomAnchor, constant: 6),
            errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func updateHeight() {
        let hasTitleText = _titleText?.isEmpty == false
        let hasErrorText = _errorMsg?.isEmpty == false
        
        switch (hasTitleText, hasErrorText) {
        case (true, true):
            heightConstraint?.constant = 86
        case (false, false):
            heightConstraint?.constant = 40
        case (true, false), (false, true):
            heightConstraint?.constant = 63
        }
    }
    
    private func setTextRect(forBounds bounds: CGRect) -> CGRect {
        let bottom: CGFloat = errorLabel.isHidden == false ? 23 : 0
        let top: CGFloat = titleLabel.isHidden == false ? self.borderView.frame.minY - (self.borderView.frame.size.height / 2) + (font?.lineHeight ?? 20 / 2) : 0
        let padding = UIEdgeInsets(top: top, left: 12, bottom: bottom, right: 12)
        return bounds.inset(by: padding)
    }
}
