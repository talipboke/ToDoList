//
//  DetailView.swift
//  GetirTodo
//
//  Created by Talip Böke on 20.04.2021.
//

import UIKit

internal final class DetailView: UIView {
    
    internal lazy var titleLabel = makeTitleLabel()
    internal lazy var titleTextField = makeTitleTextField()
    internal lazy var contentLabel = makeContentLabel()
    internal lazy var contentTextView = makeContentTextView()
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layoutViews()
    }
    
    internal required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

private extension DetailView {
    func layoutViews() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: UIDimension.Spacing.xlarge),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: UIDimension.Spacing.medium)
        ])
        
        addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIDimension.Spacing.small),
            titleTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -UIDimension.Spacing.medium),
            titleTextField.heightAnchor.constraint(equalToConstant: UIDimension.TextFieldHeight.medium)
        ])
        
        addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: UIDimension.Spacing.large),
            contentLabel.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
        ])
        
        addSubview(contentTextView)
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentTextView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: UIDimension.Spacing.small),
            contentTextView.leadingAnchor.constraint(equalTo: contentLabel.leadingAnchor),
            contentTextView.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            contentTextView.heightAnchor.constraint(equalToConstant: UIDimension.TextViewHeight.small)
        ])
    }
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = AppConst.title.localize()
        return label
    }
    
    func makeTitleTextField() -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }
    
    func makeContentLabel() -> UILabel {
        let label = UILabel()
        label.text = AppConst.content.localize()
        return label
    }
    
    func makeContentTextView() -> UITextView {
        let textView = UITextView()
        textView.allowsEditingTextAttributes = true
        textView.backgroundColor = .clear
        let borderColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0)
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = borderColor.cgColor
        textView.layer.cornerRadius = 5.0
        return textView
    }
}
