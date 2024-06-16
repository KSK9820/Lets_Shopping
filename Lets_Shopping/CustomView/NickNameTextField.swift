//
//  NickNameTextField.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/14/24.
//

import UIKit

final class NickNameTextField: UIView {
    
    weak var delegate: NickNameTextFieldDelegate?
    
    private let textField: UITextField = {
        let view = UITextField()
        
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        view.leftViewMode = .always
        view.textColor = .sBlack
        view.font = SystemFont.regular15
        view.attributedPlaceholder = NSAttributedString(string: "닉네임을 입력해주세요 :)", attributes: [.foregroundColor: UIColor.sMediumGray, .font: SystemFont.bold15])
        view.borderStyle = .none
       
        view.addTarget(self, action: #selector(textFieldValueChanged(_:)), for: .editingChanged)
        
        return view
    }()
    
    private let statusLabel: UILabel = {
        let view = UILabel()
        
        view.textColor = .sOrange
        view.font = SystemFont.regular13
        view.text = " "
        
        return view
    }()
    
    
    // MARK: - Initialize

    init(_ nickName: String? = nil) {
        super.init(frame: .zero)
        
        if let nickName {
            textField.text = nickName
        }

        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - override method
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textField.layer.addBorder([.bottom], color: .lightGray, width: 1, inset: -10)
    }
    
    
    // MARK: - ConfigureUI
    
    private func configureHierarchy() {
        addSubview(textField)
        addSubview(statusLabel)
    }
    
    private func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalToSuperview()
        }
        
        statusLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.bottom.equalToSuperview()
        }
        
        snp.makeConstraints { make in
            make.width.equalTo(ContentSize.screenWidth - ContentSize.nicknameTextField.spacing * 2)
        }
    }
    
    @objc
    private func textFieldValueChanged(_ sender: UITextField) {
        statusLabel.text =  delegate?.validateTextField(sender.text)
    }
    
}
